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
            String email = request.getParameter("user");
            String password = request.getParameter("pass");
        %>
        <main role="main" class="flex-shrink-0">
            <div class="container text-center">
                <div class="text-center" style="max-width:50%;margin:6rem auto 6rem auto;color:#333">
                    <div class="card text-left">
                        <div class="card-header">Create your profile</div>
                        <div class="card-body">
                            <form id="Login" action="storeProfile.jsp">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstname" name="firstName">
                                </div>
                                <div class="form-group">
                                    <label for="surName">Surname</label>
                                    <input type="surName" class="form-control" id="surName" name="surName">
                                </div>
                                <input type="hidden" name="user" value="<%=email%>">
                                <input type="hidden" name="password" value="<%=password%>">
                                <button type="submit" class="btn btn-success next">Create Account</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../footer.jsp" flush="true" />
    </body>
</html>
