<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <LINK rel='stylesheet' type='text/css' href='../mainstyle.css'>

        <!------ Include the above in your HEAD tag ---------->

    </head>
    <body id="LoginForm">
        <div class="container">
            <div class="login-form">
                <div class="main-div">
                    <div class="panel">
                        <p>Please enter your username and password</p>
                    </div>
                    <form id="Login" action="log.jsp">

                        <div class="form-group">


                            <input type="email" class="form-control" id="inputEmail" name="user" placeholder="Email Address">

                        </div>

                        <div class="form-group">

                            <input type="password" class="form-control" id="inputPassword" name="pass" placeholder="Password">

                        </div>
                        <div class="forgot">
                            <a href="new.jsp">New User? Create an account</a>
                            <br>
                            <a href="reset.jsp">Forgot your password? Reset</a>
                        </div>
                        <button type="submit" class="next">Login</button>

                    </form>
                </div>
                <p class="botto-text">Skin Deep AI &copy;&nbsp;</p>
            </div></div>


    </body>
</html>