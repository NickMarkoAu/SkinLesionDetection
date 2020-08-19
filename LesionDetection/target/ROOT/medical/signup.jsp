<%-- 
    Document   : signup
    Created on : Jul. 16, 2020, 11:16:33 p.m.
    Author     : nickm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <LINK rel='stylesheet' type='text/css' href='../mainstyle.css'>
        <script src="https://kit.fontawesome.com/d16c32e0f3.js" crossorigin="anonymous"></script>
        <title>Create Profile</title>
    </head>
    <body id='loginForm'>
        <jsp:include page="../header.jsp" flush="true" />
        <%
            String email = request.getParameter("email");
            String password = request.getParameter("password");
        %>
        <div class="container">
            <div class="login-form">
                <div class="main-div">

                    <h1>Create your profile</h1>
                    <form action='storeProfile.jsp'>
                        <table>
                            <tr>
                                <td>
                                    First name
                                </td>
                                <td>
                                    <input type='text' name='firstName'>
                                </td>
                            </tr>
                            <tr>
                                <td>Surname</td>
                                <td>
                                    <input type='text' name='surName'>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Phone
                                </td>
                                <td>
                                    <input type='text' name='phone'>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <button class='next' style='background-color: green;'>Submit</button>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" name="email" value="<%=email%>">
                        <input type="hidden" name="password" value="<%=password%>">
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="../footer.jsp" flush="true" />

    </body>
</html>
