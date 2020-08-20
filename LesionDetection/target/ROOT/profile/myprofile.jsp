<%-- 
    Document   : myprofile
    Created on : Jul. 16, 2020, 11:15:21 p.m.
    Author     : nickm
--%>

<%@page import="com.skindeep.db.LesionEntry"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Profile</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="../partSelector/index.css">
        <link rel="stylesheet" href="../mainstyle.css">

        <script type="text/javascript" src="../partSelector/index.js"></script>
    </head>
    <body>
        <% ArrayList entryList = new ArrayList();

            int userId = 0;
            try {
                userId = (Integer) session.getAttribute("user");
            } catch (NullPointerException e) {
                response.sendRedirect("index.jsp");
            }
            if (session.getAttribute("user") == null || userId == 0) {
                response.sendRedirect("index.jsp");
            }
            LesionEntry lesion = new LesionEntry();
            entryList = lesion.getByUser(userId);%>
        <jsp:include page="../header.jsp" flush="true" />

    <center>
        <table style="width: 100%;">
            <tr>
                <td>
                    <b>Body Part</b>
                </td>
                <td>
                    <b>Date Logged:</b>
                </td>
                <td>
                    <b>Date Noticed:</b>
                </td>
                <td>
                    <b>Image:</b>
                </td>
                <td>
                    <b>Results</b>
                </td>
                <td>
                    <b>View</b>
                </td>
            </tr>
            <% if (entryList.isEmpty()) { %>
            <tr>
                <td colspan="4">
                    You haven't made any entries yet. Add one now?
                    <br>
                    <button class='next' type='button' onclick="window.location.href = 'newLesion.jsp'">Add Entry</button>
                </td>
            </tr>
            <% } else { %>
            <% for (int i = 0; i < entryList.size(); i++) {
                    lesion = (LesionEntry) entryList.get(i);%>
            <tr>
                <td>
                    <%=lesion.bodyPart%>
                </td>
                <td>
                    <%=lesion.dateLogged.toOz()%>
                </td>
                <td>
                    <%=lesion.dateNoticed.toOz()%>
                </td>
                <td>
                    <img src="<%=lesion.image%>" width="60">
                </td>
                <td>
                    <% if (lesion.diagnosed) { %>
                    <b style="color: green;">READY</b>
                    <% } else { %>
                    <b style="color: yellow">PENDING</b>
                    <% }%>
                </td>
                <td>
                    <button class="next" type="button" onclick="window.location.href = 'showLesion.jsp?id=<%=lesion.getId()%>'"><i class="fas fa-eye"></i></button>
                </td>
            </tr>
            <% }%>
        </table>
        <button class='next' type='button' onclick="window.location.href = 'newLesion.jsp'">Add Entry</button>
        <% }%>
    </center>
    <jsp:include page="../footer.jsp" flush="true" />

</body>
</html>
