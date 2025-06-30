<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This page expects a 'confirmedBooking' object from the payment processing servlet.

  Example in Servlet (after successful payment):
  Booking confirmedBooking = bookingDAO.getBookingById(newBookingId);
  request.setAttribute("confirmedBooking", confirmedBooking);
  request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Booking Confirmed - CarRental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="site-wrap">
        <jsp:include page="navbarSI.jsp" />

        <div class="site-section">
            <div class="container">
                <div class="row justify-content-center text-center">
                    <div class="col-lg-8">
                        <span class="icon-check_circle display-1 text-success"></span>
                        <h2 class="display-4 mt-3">Payment Successful!</h2>
                        <p class="lead mb-5">Your car rental is confirmed. A confirmation email has been sent to ${confirmedBooking.user.email}.</p>
                        
                        <div class="bg-light p-4 rounded mb-5 text-left shadow-sm">
                            <h4 class="mb-4 border-bottom pb-3">Booking Summary</h4>
                            <div>
                                <p><strong>Confirmation #:</strong> ${confirmedBooking.id}</p>
                                <p><strong>Renter:</strong> ${confirmedBooking.user.fullName}</p>
                                <hr>
                                <p><strong>Car:</strong> ${confirmedBooking.car.title}</p>
                                <p><strong>Pickup Date:</strong> ${confirmedBooking.pickupDate}</p>
                                <p><strong>Return Date:</strong> ${confirmedBooking.returnDate}</p>
                                <hr>
                                <h5 class="text-right">
                                    <strong>Total Paid:</strong> $<fmt:formatNumber value="${confirmedBooking.totalPrice}" minFractionDigits="2"/>
                                </h5>
                            </div>
                        </div>
                        
                        <a href="<c:url value='/dashboard.jsp'/>" class="btn btn-primary py-3 px-5">Go to My Dashboard</a>
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