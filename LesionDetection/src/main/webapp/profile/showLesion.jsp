<%-- 
    Document   : showLesion
    Created on : Aug. 20, 2020, 9:32:51 p.m.
    Author     : nickm
--%>

<%@page import="com.skindeep.db.Diagnosis"%>
<%@page import="com.microsoft.azure.cognitiveservices.vision.customvision.samples.Classification"%>
<%@page import="utils.Var"%>
<%@page import="com.skindeep.db.LesionEntry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../partSelector/index.css">
        <link rel="stylesheet" href="../mainstyle.css">
        <title>Show Lesion</title>
    </head>
    <body>
        <jsp:include page="../header.jsp" flush="true" />
        <%
            Diagnosis dx = new Diagnosis();
            LesionEntry lesion = new LesionEntry();

            try {
                lesion.find(Var.parseInt(request.getParameter("id")));
                dx.findByLesion(lesion.getId());
            } catch (Exception e) {
                throw new JspException("Could not find lesion data. Please try again");
            }
        %>
        <table style="width: 100%;">
            <tr>
                <td><img src="<%=lesion.image%>" style="max-width: 300px;"></td>
                <td>
                    <b>Body Part: </b> <%=lesion.bodyPart%>
                    <br>
                    <b>Date Noticed: </b><%=lesion.dateNoticed.toFullShow()%>
                    <br>
                    <b>Date Logged: </b><%=lesion.dateLogged.toFullShow()%>
                    <br>
                    <% if (lesion.diagnosed) {%>
                    <b>Diagnosis: </b><%=Classification.allClass().get(dx.doctorDx)%>
                    <br>
                    <b>Description: </b><%=lesion.description%>
                    <% }%>
                </td>
            </tr>
        </table>

        <jsp:include page="../footer.jsp" flush="true" />
    </body>
</html>
