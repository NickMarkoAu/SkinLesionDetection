<%-- 
    Document   : error
    Created on : 15/01/2016, 12:54:13 PM
    Author     : Creator
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@page isErrorPage="true" %>
<%@page import='java.io.StringWriter, java.io.PrintWriter' %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" type="text/css" href="mainstyle.css" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <title>Message</title>
        <jsp:include page="../header.jsp" flush="true" />


    </head>
    <body>
    <center>
        <%
            StringWriter writer = new StringWriter();
            PrintWriter printWriter = new PrintWriter(writer);
            exception.printStackTrace(printWriter);
            printWriter.flush();

            String stackTrace = writer.toString();
        %>
        <div style="max-width:600px; width:95%; font-size:12pt; text-align:left;"> <!-- Page Div -->

            <div style="margin-top:20px;">
                <span style="font-size:16pt;">Oops Something Isn't Quite Right!</span><br><br>
                <%= exception.getMessage()%>
                <form action='' style="margin-top:35px;">
                    <input type='button' class='next' style="margin-left:45px;" value='BACK' onClick='history.go(-1)'>
                </form>
            </div> 


        </div>
    </center>
</body>
</html>
