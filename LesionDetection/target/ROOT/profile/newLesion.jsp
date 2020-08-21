<%-- 
    Document   : newLesion
    Created on : Aug. 19, 2020, 10:19:23 p.m.
    Author     : nickm
--%>

<%@page import="com.skindeep.db.LesionEntry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../partSelector/index.css">
        <link rel="stylesheet" href="../mainstyle.css">
        <title>New Spot</title>
        <script>
            function submitLesion() {
                if (document.getElementById("bodyPart").value === "") {
                    alert("Select a body part");
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="../header.jsp" flush="true" />

        <%
            LesionEntry lesion = new LesionEntry();
            int nextId = lesion.getNextId();
            String bodyPart = request.getParameter("part");
        %>

        <form action ="saveRecord.jsp">
            <input type="hidden" name="part" id="bodyPart" value="<%=bodyPart%>">

            Date first noticed: <input type="date" name="dateNoticed">
            <h3>Upload the file you wish to diagnose</h3>
            <br>
            <p>Please wait until a blue tick appears below before clicking diagnose</p>
            <br>
            <iframe src="uploadform.jsp?id=<%=nextId%>" height="100" width="250" frameBorder="0"></iframe>
            <br>
            <input type="hidden" name="id" value="<%=nextId%>">
            <button class="btn btn-primary" type="submit">Submit</button>
        </form>

        <br>
        <br>
        <br>
        <jsp:include page="../footer.jsp" flush="true" />

    </body>
</html>
