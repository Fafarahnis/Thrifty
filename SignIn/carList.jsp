<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This page expects a List of car objects from a servlet.
  Example in Servlet:
  List<Car> carList = carDAO.getAllCars();
  request.setAttribute("cars", carList);
  request.getRequestDispatcher("/carList.jsp").forward(request, response);
--%>
<!doctype html>
<html lang="en">
<head>
    <title>Car Listings - Thrifty</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/fonts/icomoon/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="site-wrap" id="home-section">
        <jsp:include page="navbarSI.jsp" />
        <div class="background-page">
            <div class="container">
                <div class="row align-items-end ">
                    <div class="col-lg-5">
                        <div class="intro">
                            <h1><strong>Listings</strong></h1>
                            <div class="custom-breadcrumbs"><a href="<c:url value='/dashboard.jsp'/>">Home</a> <span class="mx-2">/</span> <strong>Listings</strong></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <h2 class="section-heading"><strong>Car Listings</strong></h2>
                        <p class="mb-5">All cars are based on availability.</p>
                    </div>
                </div>

                <div class="row">
                    <%-- JSTL loop to dynamically generate car listings --%>
                    <c:forEach var="car" items="${cars}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="listing d-block align-items-stretch">
                                <div class="listing-img h-100 mr-4">
                                    <img src="<c:url value='/images/${car.imageFileName}'/>" alt="${car.model}" class="img-fluid">
                                </div>
                                <div class="listing-contents h-100">
                                    <h3>${car.model}</h3>
                                    <div class="rent-price">
                                        <strong>$${car.pricePerDay}</strong><span class="mx-1">/</span>day
                                    </div>
                                    <div class="d-block d-md-flex mb-3 border-bottom pb-3">
                                        <div class="listing-feature pr-4"><span class="caption">Luggage:</span><span class="number">${car.luggageCapacity}</span></div>
                                        <div class="listing-feature pr-4"><span class="caption">Doors:</span><span class="number">${car.doors}</span></div>
                                        <div class="listing-feature pr-4"><span class="caption">Passenger:</span><span class="number">${car.passengerCapacity}</span></div>
                                    </div>
                                    <div>
                                        <p>${car.shortDescription}</p>
                                        <p>
                                            <%-- Links pass the car's unique ID to the next page --%>
                                            <a href="<c:url value='/booking.jsp?carId=${car.id}'/>" class="btn btn-primary btn-sm">Rent Now</a>
                                            <a href="<c:url value='/carDetails?id=${car.id}'/>" class="btn btn-secondary btn-sm">View Details</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <%-- This is a fallback/message for when there are no cars to display --%>
                    <c:if test="${empty cars}">
                        <div class="col-12">
                             <p>No cars are available at the moment. Please check back later.</p>
                        </div>
                    </c:if>
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