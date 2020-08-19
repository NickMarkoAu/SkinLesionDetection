<%@page contentType="text/html"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@page import='com.skindeep.db.*,utils.*,java.sql.SQLException,java.util.*' %>
<%@page errorPage='../error.jsp' %>
<html>
    <head>
        <script>
            function redirectNoHead() {
                document.getElementById("redirect").submit();
            }
        </script>
    </head>
    <body onload="redirectNoHead()">
        <%

            User user = new User();
            User exist = new User();
            if (!Var.isFilled(request.getParameter("email")) || !Var.isFilled(request.getParameter("password"))) {
                throw new JspException("Please enter an email and a password");
            }

            PasswordAuthentication auth = new PasswordAuthentication();
            user.userName = request.getParameter("user");
            user.passHash = auth.hash(request.getParameter("password").toCharArray());
            user.firstName = request.getParameter("firstName");
            user.surName = request.getParameter("surName");
            user.phone = request.getParameter("phone");
            user.email = request.getParameter("user");
            user.type = "medical";
            if (exist.getUserId(user.email) > 0) {
                throw new JspException("User already exists. If you have forgotten your password please use the forgot my password link to reset");
            }
            try {
                user.newUser();
            } catch (SQLException e) {
                throw new JspException("There was a problem storing your account. Please email tech@ozsnow.com or call (02)9369 3010 and ask for Nick to create your account");
            }
            Log log = new Log();
            String token = "";
            token = auth.hash("authenticate".toCharArray());

            session.setAttribute("auth", token);
            session.setAttribute("user", user.getUserId(request.getParameter("user")));
            log.storeAuth(token, user.getUserId(request.getParameter("user")));
        %>
        <form action="myprofile.jsp" id="redirect">
        </form>
    </BODY>
</html>
