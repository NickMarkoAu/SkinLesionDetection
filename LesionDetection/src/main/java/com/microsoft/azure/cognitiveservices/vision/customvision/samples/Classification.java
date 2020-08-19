/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.microsoft.azure.cognitiveservices.vision.customvision.samples;

import java.util.HashMap;

/**
 *
 * @author nickm
 */
public class Classification {

    public String abrev;
    public String fullName;
    public boolean malignant;

    public Classification() {
    }

    public static HashMap<String, String> allClass() {
        HashMap<String, String> allClass = new HashMap<>();
        allClass.put("akiec", "Actinic keratoses");
        allClass.put("bcc", "Basal cell carcinoma");
        allClass.put("bkl", "Benign keratosis-like lesions");
        allClass.put("df", "Dermatofibroma");
        allClass.put("mel", "Melanoma");
        allClass.put("nv", "Melanocytic nevi");
        allClass.put("vasc", "Vascular lesions");
        return allClass;
    }

    public static boolean likelyBenign(String dx) {
        boolean result = false;
        if (dx.equals("bkl") || dx.equals("nv") || dx.equals("df") || dx.equals("vasc")) {
            result = true;
        }
        return result;
    }

}
