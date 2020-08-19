<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <LINK rel='stylesheet' type='text/css' href='../mainstyle.css'>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-client_id" content="219886256726-img8db4e446kmlmhg58efhhi7b026juh.apps.googleusercontent.com">
    </head>
    <body id="LoginForm">
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v7.0&appId=3247245835287046&autoLogAppEvents=1" nonce="2G8kbB0p"></script>
        <jsp:include page="../header.jsp" flush="true" />

        <%
        %>
        <div class="container">
            <div class="login-form">
                <div class="main-div">
                    <div class="panel">
                        <p>Please log in</p>
                    </div>
                    <center>
                        <div id="my-signin2"></div>
                        <script>
                            function onSuccess(googleUser) {
                                console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
                            }
                            function onFailure(error) {
                                console.log(error);
                            }
                            function renderButton() {
                                gapi.signin2.render('my-signin2', {
                                    'scope': 'profile email',
                                    'width': 240,
                                    'height': 50,
                                    'longtitle': true,
                                    'theme': 'dark',
                                    'onsuccess': onSuccess,
                                    'onfailure': onFailure
                                });
                            }
                        </script>    
                        <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>

                        <br>
                        <div class="fb-login-button" data-size="large" data-button-type="continue_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width=""></div>
                    </center>
                    <br>
                    <form id="Login" action="log.jsp">

                        <div class="form-group">

                            <input type="email" class="form-control" id="inputEmail" name="user" placeholder="Email Address">

                        </div>

                        <div class="form-group">

                            <input type="password" class="form-control" id="inputPassword" name="pass" placeholder="Password">

                        </div>
                        <div class="forgot">
                            <a href="signupPre.jsp">New User? Create an account</a>
                            <br>
                            <a href="reset.jsp">Forgot your password? Reset</a>
                        </div>
                        <br>
                        <button type="submit" class="next">Login</button>

                    </form>
                </div>
                <p class="botto-text">Skin Deep AI &copy;&nbsp;</p>
            </div></div>

        <jsp:include page="../footer.jsp" flush="true" />
    </body>
</html>