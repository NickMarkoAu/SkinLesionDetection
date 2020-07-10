/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.microsoft.azure.cognitiveservices.vision.customvision.samples;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author nickm
 */
public class SkinLesion {

    public String fileName;
    public String classification;

    public SkinLesion() {
    }

    public ArrayList getByClassification(String classification) throws IOException {
        ArrayList result = new ArrayList();
        String file = "data/classifications.csv";
        BufferedReader br = new BufferedReader(new FileReader(file));
        String line;
        String splitBy = ",";
        while ((line = br.readLine()) != null) {
            String[] lesions = line.split(splitBy);
            SkinLesion lesion = new SkinLesion();
            lesion.fileName = lesions[1];
            lesion.classification = lesions[2];
            if (lesion.classification.equals(classification)) {
                result.add(lesion);
            }
        }
        return result;
    }

    public File[] getTrainingImages(ArrayList classif) {
        File[] result = new File[classif.size()];
        for (int i = 0; i < classif.size(); i++) {
            SkinLesion skinLesion = (SkinLesion) classif.get(i);
            result[i] = new File("lib/TrainingImages/" + skinLesion.fileName + ".jpg");
        }
        return result;
    }

    public File[] getTestImages(ArrayList classif) {
        File[] result = new File[classif.size()];
        for (int i = 0; i < classif.size(); i++) {
            SkinLesion skinLesion = (SkinLesion) classif.get(i);
            result[i] = new File("testData/" + skinLesion.fileName + ".jpg");
        }
        return result;
    }
}
