<%-- 
    Document   : signupPre
    Created on : Jul. 16, 2020, 11:22:35 p.m.
    Author     : nickm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <LINK rel='stylesheet' type='text/css' href='../mainstyle.css'>
        <script src="https://kit.fontawesome.com/d16c32e0f3.js" crossorigin="anonymous"></script>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-client_id" content="219886256726-img8db4e446kmlmhg58efhhi7b026juh.apps.googleusercontent.com">

        <title>Sign Up</title>
    </head>
    <body id='LoginForm'>
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v7.0&appId=3247245835287046&autoLogAppEvents=1" nonce="2G8kbB0p"></script>
        <jsp:include page="../header.jsp" flush="true" />

        <div class="container">
            <div class="login-form">
                <div class="main-div">
                    <center>
                        <div id="my-signin2"></div>
                        <script>
                            function onSuccess(googleUser) {
                                //send to sign up form with details filled out
                                console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
                            }
                            function onFailure(error) {
                                //send to sign in form with error showing and details unfilled
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
                        <br>
                    </center>
                    <p style="color: white;">
                        Sign up with Email
                    </p>
                    <form action='signup.jsp'>
                        <div class="form-group">
                            <input type='email' class="form-control" id="inputEmail" name="email" placeholder="Email Address">
                        </div>
                        <div class="form-group">
                            <input type='password' class="form-control" id="inputEmail" name="password">
                        </div>
                        <br>
                        <br>
                        <button class='next'>Submit</button>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="../footer.jsp" flush="true" />


    </body>
</html>
