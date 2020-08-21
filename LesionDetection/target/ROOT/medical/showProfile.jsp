<%-- 
    Document   : showProfile
    Created on : Aug. 20, 2020, 12:27:31 a.m.
    Author     : nickm
--%>

<%@page import="com.microsoft.azure.cognitiveservices.vision.customvision.samples.Classification"%>
<%@page import="com.skindeep.db.Diagnosis"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.skindeep.db.LesionEntry"%>
<%@page import="com.skindeep.db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link rel="stylesheet" href="../mainstyle.css">

        <title>Patient Profile</title>
    </head>
    <body>
        <jsp:include page="../header.jsp" flush="true" />

        <%
            User user = new User();
            int id = Integer.parseInt(request.getParameter("id"));
            user.getUser(id);
            LesionEntry lesion = new LesionEntry();
            ArrayList lesionList = lesion.getByUser(id);
        %>
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <b> First Name:</b>
                            </td>
                            <td>
                                <%=user.firstName%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Surname:</b>
                            </td>
                            <td>
                                <%=user.surName%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Phone:</b>
                            </td>
                            <td>
                                <%=user.phone%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b> Email:</b>
                            </td>
                            <td>
                                <%=user.userName%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Actions:</b>
                            </td>
                            <td>
                                <button class="btn btn-primary btn-sm" type="button">Make Appointment</button>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <b>Lesion Location:</b>
                            </td>
                            <td>
                                <b>AI Prediction</b>
                            </td>
                            <td>

                            </td>
                        </tr>
                        <% for (int i = 0; i < lesionList.size(); i++) {
                                lesion = (LesionEntry) lesionList.get(i);
                                Diagnosis dx = new Diagnosis();
                                dx.findByLesion(lesion.getId());%>
                        <tr>
                            <td>
                                <%=lesion.bodyPart%>
                            </td>
                            <td>
                                <%=Classification.allClass().get(dx.prediction)%>
                            </td>
                            <td>
                                <button class="btn btn-primary btn-sm" type="button" onclick="window.location.href = 'showLesion.jsp?id=<%=lesion.getId()%>'"><i class="fas fa-eye"></i><</button>
                            </td>
                        </tr>
                        <% }%>
                    </table>
                </td>
            </tr>
        </table>
        <button class="btn btn-warning btn-sm" onclick="window.history.back()">Back</button>

        <jsp:include page="../footer.jsp" flush="true" />

    </body>
</html>
