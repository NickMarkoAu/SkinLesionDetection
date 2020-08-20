<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" class="h-100">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Skin lesion early warning from home">
        <meta name="author" content="Nick Marko & Tim Offereins">

        <title>Skin Deep AI · Skin Lesion Detection</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">
    </head>

    <body class="d-flex flex-column h-100">
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
            <div class="container">
                <img class="mx-auto d-block" style="margin-top:10rem;max-width:200px;" src="http://skindeep.tetradeca.com.au/logo.png">
                <div class="text-center" style="max-width:50%;margin:6rem auto 6rem auto;color:#333">
