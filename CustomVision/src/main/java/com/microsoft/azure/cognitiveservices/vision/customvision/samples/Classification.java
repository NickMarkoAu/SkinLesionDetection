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

    public HashMap<String, String> allClass() {
        HashMap<String, String> allClass = new HashMap<>();
        allClass.put("akiec", "Actinic keratoses");
        allClass.put("bcc", "basal cell carcinoma");
        allClass.put("bkl", "benign keratosis-like lesions");
        allClass.put("df", "dermatofibroma");
        allClass.put("mel", "Melanoma");
        allClass.put("nv", "melanocytic nevi");
        allClass.put("vasc", "vascular lesions");
        return allClass;
    }

}
