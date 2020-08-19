/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */
package com.microsoft.azure.cognitiveservices.vision.customvision.samples;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import com.google.common.io.ByteStreams;

import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.Classifier;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.Domain;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.DomainType;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.ImageFileCreateBatch;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.ImageFileCreateEntry;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.Iteration;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.Project;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.Region;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.TrainProjectOptionalParameter;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.CustomVisionTrainingClient;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.Trainings;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.CustomVisionTrainingManager;
import com.microsoft.azure.cognitiveservices.vision.customvision.prediction.models.ImagePrediction;
import com.microsoft.azure.cognitiveservices.vision.customvision.prediction.models.Prediction;
import com.microsoft.azure.cognitiveservices.vision.customvision.prediction.CustomVisionPredictionClient;
import com.microsoft.azure.cognitiveservices.vision.customvision.prediction.CustomVisionPredictionManager;
import com.microsoft.azure.cognitiveservices.vision.customvision.training.models.Tag;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Map;

public class LesionDetectionTest {

    /**
     * Main entry point.
     *
     * @param trainer the Custom Vision Training client object
     * @param predictor the Custom Vision Prediction client object
     */
    public static void runSample(CustomVisionTrainingClient trainer, CustomVisionPredictionClient predictor) {
        try {
            // This demonstrates how to create an image classification project, upload images,
            // train it and make a prediction.
            ImageClassification_Sample(trainer, predictor);

        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public static void ImageClassification_Sample(CustomVisionTrainingClient trainClient, CustomVisionPredictionClient predictor) {
        try {
            // <snippet_create>
            System.out.println("ImageClassification Lesion Detection");
            Trainings trainer = trainClient.trainings();

            System.out.println("Creating project...");
            Project project = trainer.createProject()
                    .withName("Lesion Detection Project")
                    .execute();
            // </snippet_create>

            // create tags
            Classification classif = new Classification();
            HashMap<String, String> allClass = classif.allClass();
            Tag lesionTag = null;
            //Loop through different classifications, create a tag with they key name and add relevant images to the training set
            for (Map.Entry me : allClass.entrySet()) {
                lesionTag = trainer.createTag()
                        .withProjectId(project.id())
                        .withName(me.getKey().toString())
                        .execute();
                System.out.println("Adding images for " + me.getKey() + "...");
                SkinLesion lesion = new SkinLesion();
                ArrayList byClass = lesion.getByClassification(me.getKey().toString());
                for (int i = 0; i < byClass.size(); i++) {
                    lesion = (SkinLesion) byClass.get(i);
                    String fileName = lesion.fileName + ".jpg";
                    byte[] contents = GetImage("/TrainingData", fileName);
                    AddImageToProject(trainer, project, fileName, contents, lesionTag.id(), null);
                }
            }

            // <snippet_train>
            System.out.println("Training...");
            Iteration iteration = trainer.trainProject(project.id(), new TrainProjectOptionalParameter());

            while (iteration.status().equals("Training")) {
                System.out.println("Training Status: " + iteration.status());
                Thread.sleep(1000);
                iteration = trainer.getIteration(project.id(), iteration.id());
            }
            System.out.println("Training Status: " + iteration.status());

            // The iteration is now trained. Publish it to the prediction endpoint.
            String publishedModelName = "myModel";
            String predictionResourceId = "/subscriptions/2f830af2-f7b1-4c2e-aadc-e7abec7f42f3/resourceGroups/SkinLesion/providers/Microsoft.CognitiveServices/accounts/PaidPrediction";
            trainer.publishIteration(project.id(), iteration.id(), publishedModelName, predictionResourceId);
            // </snippet_train>

            // use below for url
            // String url = "some url";
            // ImagePrediction results = predictor.predictions().classifyImageUrl()
            //                         .withProjectId(project.id())
            //                         .withPublishedName(publishedModelName)
            //                         .withUrl(url)
            //                         .execute();
            // <snippet_predict>
            // load test image
            byte[] testImage = GetImage("/Test", "test_image.jpg");

            // predict
            ImagePrediction results = predictor.predictions().classifyImage()
                    .withProjectId(project.id())
                    .withPublishedName(publishedModelName)
                    .withImageData(testImage)
                    .execute();

            for (Prediction prediction : results.predictions()) {
                System.out.println(String.format("\t%s: %.2f%%", prediction.tagName(), prediction.probability() * 100.0f));
            }
            // </snippet_predict>
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    // <snippet_helpers>
    private static void AddImageToProject(Trainings trainer, Project project, String fileName, byte[] contents, UUID tag, double[] regionValues) {
        System.out.println("Adding image: " + fileName);
        ImageFileCreateEntry file = new ImageFileCreateEntry()
                .withName(fileName)
                .withContents(contents);

        ImageFileCreateBatch batch = new ImageFileCreateBatch()
                .withImages(Collections.singletonList(file));

        // If Optional region is specified, tack it on and place the tag there, otherwise
        // add it to the batch.
        if (regionValues != null) {
            Region region = new Region()
                    .withTagId(tag)
                    .withLeft(regionValues[0])
                    .withTop(regionValues[1])
                    .withWidth(regionValues[2])
                    .withHeight(regionValues[3]);
            file = file.withRegions(Collections.singletonList(region));
        } else {
            batch = batch.withTagIds(Collections.singletonList(tag));
        }

        trainer.createImagesFromFiles(project.id(), batch);
    }

    private static byte[] GetImage(String folder, String fileName) {
        try {
            return ByteStreams.toByteArray(LesionDetectionTest.class.getResourceAsStream(folder + "/" + fileName));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    private static byte[] getImageFromURL(String imgUrl) throws IOException {
        URL url = new URL(imgUrl);
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        URLConnection conn = url.openConnection();
        conn.setRequestProperty("User-Agent", "Firefox");

        try ( InputStream inputStream = conn.getInputStream()) {
            int n = 0;
            byte[] buffer = new byte[1024];
            while (-1 != (n = inputStream.read(buffer))) {
                output.write(buffer, 0, n);
            }
        }
        byte[] img = output.toByteArray();
        return img;
    }

    public ArrayList predict(String imgUrl) throws IOException {
        final String predictionApiKey = "44ca5a318b3040188f0b17bc29db9427";

        final String Endpoint = "https://australiaeast.api.cognitive.microsoft.com/";

        CustomVisionPredictionClient predictor = CustomVisionPredictionManager.authenticate("https://{Endpoint}/customvision/v3.0/prediction/", predictionApiKey).withEndpoint(Endpoint);

        byte[] testImage = getImageFromURL(imgUrl);

        // predict
        ImagePrediction results = predictor.predictions().classifyImage()
                .withProjectId(UUID.fromString("ad515133-46e4-4097-a0c3-9a07a5c14bff"))
                .withPublishedName("Iteration2")
                .withImageData(testImage)
                .execute();

        ArrayList result = new ArrayList();
        HashMap<String, Double> resultMap = new HashMap<>();
        for (Prediction prediction : results.predictions()) {
            if (prediction.probability() * 100.0f > 5) {
                result.add(String.format("\t%s: %.2f%%", Classification.allClass().get(prediction.tagName()), prediction.probability() * 100.0f));
            }
            resultMap.put(prediction.tagName(), prediction.probability() * 100.0f);
        }
        //System.out.println(result);

        double maxResult = 0;
        String maxDx = null;
        for (Map.Entry me : resultMap.entrySet()) {
            if ((Double) me.getValue() > maxResult) {
                maxResult = (Double) me.getValue();
                maxDx = me.getKey().toString();
            }
        }
        String dxString = "";
        if (maxResult < 40) {
            dxString += "<br><b>Diagnosis is inconclusive. Please check with a medical professional.</b>";
        } else {
            dxString += "<br><b>Diagnosis is " + Classification.allClass().get(maxDx) + " and is likely ";

            if (Classification.likelyBenign(maxDx)) {
                dxString += "benign</b>";
            } else {
                dxString += "malignant</b>";
            }
        }
        result.add(dxString);
        return result;
    }
    // </snippet_helpers>

    /**
     * Main entry point.
     *
     * @param args the parameters
     */
    /* public static void main(String[] args) {
        try {
            //=============================================================
            // Authenticate

            final String CustomVisionTrainingClientKey = "4700958328134eb58a59f84eeececb8b";
            final String predictionApiKey = "44ca5a318b3040188f0b17bc29db9427";

            final String Endpoint = "https://australiaeast.api.cognitive.microsoft.com/";

            CustomVisionTrainingClient trainClient = CustomVisionTrainingManager.authenticate("https://{Endpoint}/customvision/v3.0/training/", CustomVisionTrainingClientKey).withEndpoint(Endpoint);
            CustomVisionPredictionClient predictClient = CustomVisionPredictionManager.authenticate("https://{Endpoint}/customvision/v3.0/prediction/", predictionApiKey).withEndpoint(Endpoint);

            runSample(trainClient, predictClient);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    } */
}
