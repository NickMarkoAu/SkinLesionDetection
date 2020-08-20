<html>
    <head>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-client_id" content="219886256726-img8db4e446kmlmhg58efhhi7b026juh.apps.googleusercontent.com">
    </head>
    <body id="LoginForm">
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v7.0&appId=3247245835287046&autoLogAppEvents=1" nonce="2G8kbB0p"></script>
        <jsp:include page="../header.jsp" flush="true" />
        <div class="card text-left">
            <div class="card-header">Please Login</div>
            <div class="card-body">
                <form action="log.jsp">
                    <div class="form-group">
                        <label for="user-login">Email address</label>
                        <input type="email" class="form-control" id="inputEmail" name="user" aria-describedby="emailHelp">
                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                    </div>
                    <div class="form-group">
                        <label for="user-password">Password</label>
                        <input type="password" class="form-control" id="inputPassword" name="pass">
                    </div>
                    <button type="submit" class="btn btn-success btn-lg next" style="width:194px;height:30px;padding:.2rem;margin-bottom:.5em">Login with Email</button>
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
                                'width': 194,
                                'height': 30,
                                'longtitle': true,
                                'theme': 'dark',
                                'onsuccess': onSuccess,
                                'onfailure': onFailure
                            });
                        }
                    </script>
                    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
                    <div class="fb-login-button" data-size="medium" data-button-type="continue_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="" style="margin-top:.5em"></div>
                </form>
            </div>
            <div class="card-footer">
                <a class="btn btn-primary btn-sm" href="new.jsp">Create account</a>
                <a class="btn btn-warning btn-sm" href="reset.jsp">Reset password</a>
            </div>
        </div>
        <jsp:include page="../footer.jsp" flush="true" />
    </body>
</html>