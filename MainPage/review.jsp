<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Reviews - Thrifty Car Rental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="site-wrap" id="home-section">
        <jsp:include page="navbarSU.jsp" />
        <div class="background-page">
            <div class="container"><div class="intro"><h1><strong>Reviews</strong></h1><div class="custom-breadcrumbs"><a href="<c:url value='/home.jsp'/>">Home</a><span class="mx-2">/</span><strong>Reviews</strong></div></div></div>
        </div>
        <div class="site-section bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7"><h2 class="section-heading"><strong>Reviews</strong></h2><p class="mb-5">"Best rental experience ever..."</p></div>
                </div>
                <div class="row">
                    <c:forEach var="review" items="${reviewsList}"> <%-- Example of dynamic reviews --%>
                        <div class="col-lg-4 mb-4">
                            <div class="testimonial-2">
                                <blockquote class="mb-4"><p>"${review.comment}"</p></blockquote>
                                <div class="d-flex v-card align-items-center">
                                    <img src="<c:url value='/images/avatars/${review.user.avatar}'/>" class="img-fluid mr-3">
                                    <div><span class="d-block">${review.user.name}</span><span>Customer</span></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <%-- Static examples as fallback --%>
                    <div class="col-lg-4 mb-4"><div class="testimonial-2"><blockquote class="mb-4"><p>"Booking a car with Thrifty was fast and seamless."</p></blockquote><div class="d-flex v-card align-items-center"><img src="<c:url value='/images/person_1.jpg'/>" class="img-fluid mr-3"><div><span class="d-block">Mike Fisher</span></div></div></div></div>
                    <div class="col-lg-4 mb-4"><div class="testimonial-2"><blockquote class="mb-4"><p>"The rental process was smooth from start to finish."</p></blockquote><div class="d-flex v-card align-items-center"><img src="<c:url value='/images/person_2.jpg'/>" class="img-fluid mr-3"><div><span class="d-block">Jean Stanley</span></div></div></div></div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </div>
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>