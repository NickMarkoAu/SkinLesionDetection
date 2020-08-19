<%-- 
    Document   : uploadImage
    Created on : Jul. 13, 2020, 10:25:12 p.m.
    Author     : nickm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <LINK rel='stylesheet' type='text/css' href="mainstyle.css'>
              <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/d16c32e0f3.js" crossorigin="anonymous"></script>

        <title>Upload Image</title>

    </head>
    <body>
        <jsp:include page="header.jsp" flush="true" />

        <% String name = request.getParameter("name").replaceAll(" ", "");
            String bodyPart = request.getParameter("bodyPart").replaceAll(" ", "");
        %>
    <center>
        <h1>Upload the file you wish to diagnose</h1>
        <br>
        <p>Please wait until a blue tick appears below before clicking diagnose</p>
        <br>
        <iframe src="uploadform.jsp?name=<%=name%>&bodyPart=<%=bodyPart%>" height="100" width="250" frameBorder="0"></iframe>
        <br>
        <br>
        <button type="button" class="btn btn-outline-success" onclick="window.location.href = 'diagnose.jsp?name=<%=name%>&bodyPart=<%=bodyPart%>'">Diagnose</button>
        <br>
        <br>

    </center>
    <jsp:include page="footer.jsp" flush="true" />

</body>
</html>
