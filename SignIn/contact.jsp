<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Contact Us - Thrifty Car Rental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="site-wrap">
        <jsp:include page="navbarSI.jsp" />
        <div class="background-page">
            <div class="container">
                <div class="intro"><h1><strong>Contact</strong></h1>
                    <div class="custom-breadcrumbs"><a href="<c:url value='/index.jsp'/>">Home</a> <span class="mx-2">/</span> <strong>Contact</strong></div>
                </div>
            </div>
        </div>
        <div class="site-section bg-light" id="contact-section">
            <div class="container">
                <div class="row justify-content-center text-center">
                    <div class="col-7 text-center mb-5">
                        <h2>Contact Us for Any Enquiry</h2>
                        <p>We will try to reply as soon as possible</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8 mb-5">
                        <%-- The form submits to a 'contact' servlet --%>
                        <form action="<c:url value='/contact'/>" method="post">
                            <div class="form-group row">
                                <div class="col-md-6 mb-4"><input type="text" name="firstName" class="form-control" placeholder="First name" required></div>
                                <div class="col-md-6"><input type="text" name="lastName" class="form-control" placeholder="Last name" required></div>
                            </div>
                            <div class="form-group row"><div class="col-md-12"><input type="email" name="email" class="form-control" placeholder="Email address" required></div></div>
                            <div class="form-group row"><div class="col-md-12"><textarea name="message" class="form-control" placeholder="Write your message." cols="30" rows="10" required></textarea></div></div>
                            <div class="form-group row"><div class="col-md-6 mr-auto"><input type="submit" class="btn btn-block btn-primary text-white py-3 px-5" value="Send Message"></div></div>
                        </form>
                    </div>
                    <div class="col-lg-4 ml-auto">
                        <div class="bg-white p-3 p-md-5">
                            <h3 class="text-black mb-4">Contact Info</h3>
                            <ul class="list-unstyled footer-link">
                                <li class="d-block mb-3"><span class="d-block text-black">Address:</span><span>Jasin, Melaka</span></li>
                                <li class="d-block mb-3"><span class="d-block text-black">Phone:</span><span>+60 0194357257</span></li>
                                <li class="d-block mb-3"><span class="d-block text-black">Email:</span><span>info@ythrifty.com</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </div>
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>