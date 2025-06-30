<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This page expects a single 'car' object from a servlet.
  Example in Servlet:
  int carId = Integer.parseInt(request.getParameter("id"));
  Car car = carDAO.getCarById(carId);
  request.setAttribute("car", car);
  request.getRequestDispatcher("/car-details.jsp").forward(request, response);
--%>
<!doctype html>
<html lang="en">
<head>
    <title>${car.title} - CarRental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="site-wrap">
        <jsp:include page="navbarSI.jsp" />
        <div class="background-page">
            <div class="container">
                <div class="row align-items-end">
                    <div class="col-lg-5">
                        <div class="intro">
                            <h1><strong>${car.title}</strong></h1>
                            <div class="custom-breadcrumbs"><a href="<c:url value='/'/>">Home</a> <span class="mx-2">/</span> <a href="<c:url value='/carList.jsp'/>">Listings</a> <span class="mx-2">/</span> <strong>Details</strong></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <img src="<c:url value='/images/${car.images[0]}'/>" class="main-image img-fluid">
                        <div class="mb-5 bg-white p-4 rounded">
                            <h3 class="mb-4">Description</h3>
                            <p>${car.description}</p>
                            <h3 class="mb-4 mt-5">Specifications</h3>
                            <div class="specs-grid">
                                <div class="d-flex mb-3"><div class="spec-icon"><i class="fas fa-car"></i></div><div><h5 class="mb-1">Type</h5><p class="text-muted">${car.type}</p></div></div>
                                <div class="d-flex mb-3"><div class="spec-icon"><i class="fas fa-gas-pump"></i></div><div><h5 class="mb-1">Fuel Efficiency</h5><p class="text-muted">${car.fuel}</p></div></div>
                                <div class="d-flex mb-3"><div class="spec-icon"><i class="fas fa-cogs"></i></div><div><h5 class="mb-1">Transmission</h5><p class="text-muted">${car.transmission}</p></div></div>
                                <div class="d-flex mb-3"><div class="spec-icon"><i class="fas fa-users"></i></div><div><h5 class="mb-1">Capacity</h5><p class="text-muted">${car.capacity}</p></div></div>
                                <div class="d-flex mb-3"><div class="spec-icon"><i class="fas fa-suitcase"></i></div><div><h5 class="mb-1">Luggage</h5><p class="text-muted">${car.luggage}</p></div></div>
                                <div class="d-flex mb-3"><div class="spec-icon"><i class="fas fa-door-open"></i></div><div><h5 class="mb-1">Doors</h5><p class="text-muted">${car.doors}</p></div></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="bg-white p-4 rounded sticky-top" style="top: 20px;">
                            <h2 class="mb-3">${car.title}</h2>
                            <h4 class="text-primary mb-4">$${car.pricePerDay} <small>/ day</small></h4>
                            <div class="mb-4">
                                <h5 class="mb-3">Features</h5>
                                <div>
                                    <c:forEach var="feature" items="${car.features}">
                                        <span class="feature-badge"><i class="fas fa-check"></i> ${feature}</span>
                                    </c:forEach>
                                </div>
                            </div>
                            <a href="<c:url value='/booking.jsp?carId=${car.id}'/>" class="btn btn-primary btn-block py-3">Rent This Car</a>
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