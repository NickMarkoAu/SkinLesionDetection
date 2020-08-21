<%-- 
    Document   : dashboard
    Created on : Aug. 20, 2020, 12:18:05 a.m.
    Author     : nickm
--%>

<%@page import="com.skindeep.db.LesionEntry"%>
<%@page import="com.skindeep.db.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../mainstyle.css">

        <title>Dashboard</title>
    </head>
    <body>
        <jsp:include page="../header.jsp" flush="true" />

        <% ArrayList userList = new ArrayList();
            User user = new User();
            userList = user.getPatients();
        %>
        <h2>Pending Patient Reviews</h2>
        <table style="width: 100%;">
            <tr>
                <td>
                    <b>First Name:</b>
                </td>
                <td>
                    <b>Surname:</b>
                </td>
                <td>
                    <b>Lesions to review:</b>
                </td>
                <td>
                    <b>Severity Rating:</b>
                </td>
                <td></td>
            </tr>
            <%for (int i = 0; i < userList.size(); i++) {
                    LesionEntry lesion = new LesionEntry();
                    user = (User) userList.get(i);
                    ArrayList lesionList = lesion.getByUser(user.userId);
                    if (!lesionList.isEmpty()) {%>
            <tr>
                <td>
                    <%=user.firstName%>
                </td>
                <td>
                    <%=user.surName%>
                </td>
                <td>
                    <%=lesionList.size()%>
                </td>
                <td>
                    TBA
                </td>
                <td>
                    <button class="btn btn-primary btn-sm" type="button" onclick="window.location.href = 'showProfile.jsp?id=<%=user.userId%>'">View</button>
                </td>
            </tr>
            <% }
                }
            %>
        </table>
        <jsp:include page="../footer.jsp" flush="true" />

    </body>
</html>
