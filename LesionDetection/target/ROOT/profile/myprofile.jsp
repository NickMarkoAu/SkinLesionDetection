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
        <script type="text/javascript" src="../partSelector/index.js"></script>
    </head>
    <body>
        <% ArrayList entryList = new ArrayList();
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            }
            int userId = (Integer) session.getAttribute("user");
            LesionEntry lesion = new LesionEntry();
            entryList = lesion.getByUser(userId);%>
        <jsp:include page="../header.jsp" flush="true" />

    <center>
        <table>
            <tr>
                <td>
                    Body Part
                </td>
                <td>
                    Date Logged:
                </td>
                <td>
                    Date Noticed:
                </td>
                <td>
                    Image:
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
                    <img src="<%=lesion.image%>" width="100">
                </td>
            </tr>
            <% }%>
        </table>
    </center>
    <jsp:include page="../footer.jsp" flush="true" />

</body>
</html>
