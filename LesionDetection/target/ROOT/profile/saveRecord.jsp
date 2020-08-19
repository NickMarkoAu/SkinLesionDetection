<%-- 
    Document   : saveRecord
    Created on : Aug. 12, 2020, 12:20:36 a.m.
    Author     : nickm
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="utils.OzDate"%>
<%@page import="com.skindeep.db.LesionEntry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            
            LesionEntry lesion = new LesionEntry();
            lesion.bodyPart = request.getParameter("bodyPart");
            lesion.dateLogged = new OzDate(0);
            lesion.dateNoticed = new OzDate(request.getParameter("dateNoticed"));
            lesion.description = null;
            lesion.image = null;
            lesion.userId = Integer.parseInt((String) session.getAttribute("userId"));
            
            try {
                lesion.store();
            } catch (SQLException e) {
                throw new JspException("Could not store lesion record details, please try again");
            }
        
        %>
    </body>
</html>
