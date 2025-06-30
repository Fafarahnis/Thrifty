<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Thrifty Car Rental - Welcome</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    
     <!--- Style -->
    <style>
     .font1 {
      font-family: "Outfit", sans-serif;
  font-optical-sizing: auto;
       }

      .site-menu .active > a {
     font-weight: bold; /* Make it bold */
     }
</style>

</head>
<body>
    <div class="site-wrap" id="home-section">
        <jsp:include page="navbarSU.jsp" />
        <div class="hero" style="background-image: url('<c:url value='/images/hero_1_a.jpg'/>');">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-lg-10">
                        <div class="row mb-5">
                            <div class="col-lg-7 intro"><h1><strong>Rent a car</strong> is within your fingertips.</h1></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <h2 class="section-heading"><strong>How it works?</strong></h2>
                <p class="mb-5">Easy steps to get you started</p>
                <div class="row mb-5">
                    <div class="col-lg-4 mb-4 mb-lg-0"><div class="step"><span>1</span><div class="step-inner"><h3>Sign In/Up</h3><p>Create an account or sign in to get started.</p></div></div></div>
                    <div class="col-lg-4 mb-4 mb-lg-0"><div class="step"><span>2</span><div class="step-inner"><h3>Select Car</h3><p>Browse our fleet and choose your ideal vehicle.</p></div></div></div>
                    <div class="col-lg-4 mb-4 mb-lg-0"><div class="step"><span>3</span><div class="step-inner"><h3>Payment</h3><p>Pay securely online and receive instant confirmation.</p></div></div></div>
                </div>
            </div>
        </div>
        
              <div class="site-section">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-lg-7 text-center order-lg-2">
              <div class="img-wrap-1 mb-5">
                <img src="../images/feature_01.png" alt="Image" class="img-fluid">
              </div>
            </div>
            <div class="col-lg-4 ml-auto order-lg-1">
              <h3 class="mb-4 section-heading"><strong>You can easily avail our promo for renting a car.</strong></h3>
              <p class="mb-5">Take advantage of our limited-time offers and enjoy premium 
                vehicles at unbeatable prices. Whether you need wheels for a weekend getaway or a long-term business trip,
                 we have special deals to make your journey more affordable.</p>
              
              <p><a href="<c:url value='signinup.jsp'/>" class="btn btn-primary">Meet them now</a></p>
            </div>
          </div>
        </div>
      </div>
      
        <jsp:include page="footer.jsp" />
    </div>
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/js/main.js'/>"></script>
</body>
</html>