<%-- 
    Document   : diagnose
    Created on : Jul. 13, 2020, 10:25:18 p.m.
    Author     : nickm
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="com.microsoft.azure.cognitiveservices.vision.customvision.samples.LesionDetectionTest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <LINK rel='stylesheet' type='text/css' href='mainstyle.css'>
        <script src="https://kit.fontawesome.com/d16c32e0f3.js" crossorigin="anonymous"></script>
        <title>Diagnose</title>
        <jsp:include page="header.jsp" flush="true" />
    </head>
    <body>
    <center>
        <% LesionDetectionTest lesion = new LesionDetectionTest();
            String filePath = "/home/tetradeca/apache-tomcat-9.0.37/webapps/uploads/lesions/" + request.getParameter("name") + request.getParameter("bodyPart");
            File folder = new File(filePath);
            String name = request.getParameter("name");
            String bodyPart = request.getParameter("bodyPart");
            File[] fileList = folder.listFiles();
            for (int i = 0; i < fileList.length; i++) {
                if (fileList[i].isFile()) {%>
        <img src="http://skindeep.tetradeca.com.au/uploads/lesions/<%=name%><%=bodyPart%>/<%=fileList[i].getName()%>" style="width: 200px;">
        <br>
        <h2>Predictions</h2>
        <p style="width: 90%;">
            <%ArrayList dx = lesion.predict("http://skindeep.tetradeca.com.au/uploads/lesions/" + name + bodyPart + "/" + fileList[i].getName());
                for (int j = 0; j < dx.size(); j++) {
                    String current = (String) dx.get(j);%>
            <%=current%><br>
            <% } %>
            <% }
                }
            %>
        </p>
        <br>
        <button type="button" class="btn btn-outline-success" onclick="window.location.href = 'details.jsp?tc=true'">Diagnose Another</button>
        <br>
        <br>
    </center>
    <jsp:include page="footer.jsp" flush="true" />

</body>
</html>
