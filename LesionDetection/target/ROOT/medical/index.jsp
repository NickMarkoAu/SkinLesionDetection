<!DOCTYPE html>
<html lang="en" class="h-100">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Skin lesion early warning from home">
		<meta name="author" content="Nick Marko & Tim Offereins">

		<title>Skin Deep AI � Medical Login</title>

		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	</head>

	<body class="d-flex flex-column h-100" id="LoginForm">
    <!-- Navbar -->
		<header>
			<nav class="navbar navbar-expand-md navbar-light fixed-top" style="background-color:#ffdab9;">
				<div class="container">
					<a class="navbar-brand" href="https://tetradeca.com.au">
						<img src="https://tetradeca.com.au/assets/logo.png" width="140" height="40" alt="" loading="lazy">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarCollapse">
						<ul class="navbar-nav mr-auto">
							<li class="nav-item">
								<a class="nav-link" href="https://tetradeca.com.au">Home</span></a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" href="#">Skin Deep <span class="sr-only">(current)</span></a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="https://tetradeca.com.au/project/">Project Details</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="https://tetradeca.com.au/team/">About us</a>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		</header>      
		<main role="main" class="flex-shrink-0">
    	<div class="container text-center">
        <img class="mx-auto d-block" style="margin-top:10rem;max-width:300px;" src="logo.png">
				<div class="text-center" style="max-width:50%;margin:6rem auto 6rem auto;color:#333">
					<form id="Login" action="log.jsp">
						<div class="form-group">
							<label for="user-email">Email address</label>
							<input type="email" class="form-control" id="inputEmail" name="user" aria-describedby="emailHelp">
							<small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
						</div>
						<div class="form-group">
							<label for="user-password">Password</label>
							<input type="password" class="form-control" id="inputPassword" name="pass">
						</div>
						<div class="form-group">
							<a class="btn btn-primary btn-sm" href="new.jsp">Create account</a>
							<a class="btn btn-warning btn-sm" href="reset.jsp">Reset password</a>
						</div>
						<button type="submit" class="btn btn-success next">Login</button>
					</form>
				</div>
			</div>
		</main>
		<footer class="footer mt-auto py-3" style="background-color:#f5f5f5">
            <div class="container">
                <span class="text-muted">Skin deep is still under active development. As such there may be visual discrepancies. <a class="btn btn-secondary float-right" href='../medical/index.jsp'>Medical Professional Login</a></span>
            </div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    </body>
</html>