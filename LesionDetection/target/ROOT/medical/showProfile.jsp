<%-- 
    Document   : showProfile
    Created on : Aug. 20, 2020, 12:27:31 a.m.
    Author     : nickm
--%>

<%@page import="com.skindeep.db.Diagnosis"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.skindeep.db.LesionEntry"%>
<%@page import="com.skindeep.db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Profile</title>
    </head>
    <body>
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
                                First Name:
                            </td>
                            <td>
                                <%=user.firstName%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Surname:
                            </td>
                            <td>
                                <%=user.surName%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Phone:
                            </td>
                            <td>
                                <%=user.phone%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Email:
                            </td>
                            <td>
                                <%=user.userName%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Actions:
                            </td>
                            <td>
                                <button class="next" type="button">Make Appointment</button> &nbsp;&nbsp;Submit Results<button class="next" type="button">Submit Results</button>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                Lesion Location:
                            </td>
                            <td>
                                AI Prediction
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
                                <%=dx.prediction%>
                            </td>
                            <td>
                                <button class="next" type="button" onclick="window.location.href = 'viewLesion.jsp?id=<%=lesion.getId()%>'">View</button>
                            </td>
                        </tr>
                        <% }%>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
