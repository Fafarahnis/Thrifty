<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>About Us - Thrifty Car Rental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="site-wrap" id="home-section">
        <jsp:include page="navbarSU.jsp" />
        <div class="background-page">
            <div class="container"><div class="intro"><h1><strong>About</strong></h1><div class="custom-breadcrumbs"><a href="<c:url value='/home.jsp'/>">Home</a><span class="mx-2">/</span><strong>About</strong></div></div></div>
        </div>
        <div class="site-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 mb-5 mb-lg-0 order-lg-2"><img src="<c:url value='/images/hero_2.jpg'/>" alt="Image" class="img-fluid rounded"></div>
                    <div class="col-lg-4 mr-auto"><h2>Car Company</h2><br><p>Thrifty Car Rental has been serving customers in Jasin for years...</p></div>
                </div>
            </div>
        </div>
        <div class="site-section bg-light">
            <div class="container">
                <h2 class="mb-4 text-center">Meet Our Team</h2>
                <div class="row align-items-stretch">
                    <div class="col-lg-4 col-md-6 mb-5"><div class="post-entry-1 h-100 person-1"><img src="<c:url value='/images/person_1.jpg'/>" class="img-fluid"><div class="post-entry-1-contents"><span class="meta">Founder</span><h2>James Doe</h2><p>"Rent with Confidence!"</p></div></div></div>
                    <div class="col-lg-4 col-md-6 mb-5"><div class="post-entry-1 h-100 person-1"><img src="<c:url value='/images/person_2.jpg'/>" class="img-fluid"><div class="post-entry-1-contents"><span class="meta">Founder</span><h2>Katherine Smith</h2><p>"More Miles, Less Money!"</p></div></div></div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </div>
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>