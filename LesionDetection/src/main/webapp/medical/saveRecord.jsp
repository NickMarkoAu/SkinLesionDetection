<%-- 
    Document   : saveRecord
    Created on : Aug. 12, 2020, 12:20:36 a.m.
    Author     : nickm
--%>

<%@page import="utils.Var"%>
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
            lesion.find(Var.parseInt(request.getParameter("id")));

            lesion.description = request.getParameter("description");
            lesion.diagnosed = true;

            lesion.update();

            Diagnosis dx = new Diagnosis();
            dx.findByLesion(lesion.getId());

            dx.doctorDx = request.getParameter("diagnosis");
            if (dx.prediction.equals(dx.doctorDx)) {
                dx.verified = true;
            } else {
                dx.verified = false;
            }
            dx.update();
            response.sendRedirect("dashboard.jsp");

        %>
    </body>
</html>
