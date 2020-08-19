<%@page contentType="text/html"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@page import='com.skindeep.db.*,utils.*,java.sql.SQLException,java.util.*,java.security.SecureRandom' %>
<%@page errorPage='error.jsp' %>
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
            Log log = new Log();
            PasswordAuthentication auth = new PasswordAuthentication();
            String token = "";
            if ((String) session.getAttribute("auth") != null) {
                session.removeAttribute("auth");
                session.removeAttribute("user");
        %>
        <form action="index.jsp" id="redirect">
        </form>
        <% } else {
            try {
                if (log.agentLog(request.getParameter("user"), request.getParameter("pass"))) {

                    token = auth.hash("authenticate".toCharArray());

                    session.setAttribute("auth", token);
                    session.setAttribute("user", user.getUserId(request.getParameter("user")));
                    log.storeAuth(token, user.getUserId(request.getParameter("user")));
        %>
        <form action="myProfile.jsp" id="redirect">
        </form>
        <% } else { %>
        <form action="index.jsp" id="redirect">
        </form>
        <% }
                } catch (Exception e) {
                    throw new JspException("Incorrect Username or Password Combination. Please try again or click forgot my password to reset");
                }
            }%>
    </BODY>
</html>
