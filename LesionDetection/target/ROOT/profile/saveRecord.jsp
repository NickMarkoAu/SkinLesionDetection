<%-- 
    Document   : saveRecord
    Created on : Aug. 12, 2020, 12:20:36 a.m.
    Author     : nickm
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="com.microsoft.azure.cognitiveservices.vision.customvision.samples.LesionDetectionTest"%>
<%@page import="com.skindeep.db.Diagnosis"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utils.OzDate"%>
<%@page import="com.skindeep.db.LesionEntry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%

            LesionEntry lesion = new LesionEntry();
            lesion.bodyPart = request.getParameter("bodyPart");
            lesion.dateLogged = new OzDate(0);
            lesion.dateNoticed = new OzDate(request.getParameter("dateNoticed"));
            lesion.description = null;
            String filePath = "/home/tetradeca/apache-tomcat-9.0.37/webapps/uploads/lesions/" + request.getParameter("id");
            File folder = new File(filePath);
            File[] fileList = folder.listFiles();
            for (int i = 0; i < fileList.length; i++) {
                if (fileList[i].isFile()) {
                    lesion.image = "http://skindeep.tetradeca.com.au/uploads/lesions/" + request.getParameter("id") + "/" + fileList[i].getName();
                }
            }
            lesion.userId = (Integer) session.getAttribute("user");

            try {
                lesion.store();
            } catch (SQLException e) {
                throw new JspException("Could not store lesion record details, please try again");
            }

            Diagnosis dx = new Diagnosis();
            LesionDetectionTest detect = new LesionDetectionTest();
            HashMap<String, Double> resultMap = new HashMap<>();
            resultMap = detect.predictMap(lesion.image);

            dx.akiec = resultMap.get("akiec");
            dx.bcc = resultMap.get("bcc");
            dx.bkl = resultMap.get("bkl");
            dx.df = resultMap.get("df");
            dx.mel = resultMap.get("mel");
            dx.nv = resultMap.get("nx");
            dx.vasc = resultMap.get("vasc");
            dx.prediction = detect.maxDx(resultMap);
            dx.verified = false;
            try {
                dx.store();
            } catch (SQLException e) {
                throw new JspException("Could not store lesion record details, please try again");
            }
            response.sendRedirect("myprofile.jsp");

        %>
    </body>
</html>
