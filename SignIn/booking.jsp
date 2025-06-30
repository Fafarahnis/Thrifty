<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This page expects a 'car' object and a 'user' object from a servlet.
  The servlet fetches the car by ID from the URL and gets the logged-in user from the session.

  Example in a Pre-Booking Servlet:
  String carId = request.getParameter("carId");
  Car car = carDAO.getCarById(carId);
  User user = (User) request.getSession().getAttribute("user");

  request.setAttribute("car", car);
  request.setAttribute("user", user);
  request.getRequestDispatcher("/booking.jsp").forward(request, response);
--%>
<!doctype html>
<html lang="en">
<head>
    <title>Booking - ${car.title}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/fonts/icomoon/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap-datepicker.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="site-wrap">
        <jsp:include page="navbarSI.jsp" />
          
        <div class="background-page">
          <div class="container">
            <div class="row align-items-end ">
              <div class="col-lg-5">
                <div class="intro">
                  <h1><strong>Booking</strong></h1>
                  <div class="custom-breadcrumbs"><a href="<c:url value='/index.jsp'/>">Home</a> <span class="mx-2">/</span> <a href="<c:url value='/carList.jsp'/>">Listings</a> <span class="mx-2">/</span> <strong>Booking</strong></div>
                </div>
              </div>
            </div>
          </div>
        </div>
          
        <div class="site-section bg-light">
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-lg-10">
                <div class="booking-form p-4 rounded shadow-sm bg-white">
                  <h2 class="mb-4">Car Rental Booking Form</h2>
                  
                  <%-- This form submits to a processing servlet, e.g., '/processBooking' --%>
                  <form id="bookingForm" action="<c:url value='/processBooking'/>" method="POST">
                    
                    <%-- Hidden input to pass the car ID to the next step --%>
                    <input type="hidden" name="carId" value="${car.id}">
                    
                    <h4 class="mb-3">Personal Information</h4>
                    <p class="text-muted">Please confirm your details below.</p>
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="custName" class="form-label">Full Name*</label>
                        <input type="text" id="custName" name="customerName" class="form-control" value="${user.fullName}" required>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="custIc" class="form-label">NRIC/Passport Number*</label>
                        <input type="text" id="custIc" name="nric" class="form-control" value="${user.nric}" required pattern="[0-9]{12}" title="Please enter a valid 12-digit NRIC number">
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="phone" class="form-label">Phone Number*</label>
                        <input type="tel" id="phone" name="phone" class="form-control" value="${user.phone}" required pattern="[0-9]{10,11}" title="Please enter a valid phone number">
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="email" class="form-label">Email Address*</label>
                        <input type="email" id="email" name="email" class="form-control" value="${user.email}" required>
                      </div>
                    </div>
                    
                    <h4 class="mb-3 mt-5">Rental Information</h4>
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="carModel" class="form-label">Car Model</label>
                        <input type="text" id="carModel" class="form-control" value="${car.title}" readonly>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="carType" class="form-label">Car Type</label>
                        <input type="text" id="carType" class="form-control" value="${car.type}" readonly>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="pickupDate" class="form-label">Pickup Date*</label>
                        <input type="text" id="pickupDate" name="pickupDate" class="form-control datepicker" required autocomplete="off">
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="returnDate" class="form-label">Return Date*</label>
                        <input type="text" id="returnDate" name="returnDate" class="form-control datepicker" required autocomplete="off">
                      </div>
                    </div>
                    
                    <div class="text-right mt-4">
                      <button type="submit" class="btn btn-primary py-3 px-5">Proceed to Payment</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>

        <jsp:include page="footer.jsp" />
    </div>

    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/popper.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap-datepicker.min.js'/>"></script>
    <script src="<c:url value='/js/main.js'/>"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize datepicker
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                startDate: '0d' // Cannot select past dates
            });

            // Basic front-end validation for dates
            $('#bookingForm').on('submit', function(e) {
                const pickup = $('#pickupDate').val();
                const dropoff = $('#returnDate').val();

                if (pickup && dropoff && new Date(dropoff) <= new Date(pickup)) {
                    alert('Return date must be after the pickup date.');
                    e.preventDefault(); // Prevent form submission
                }
            });
        });
    </script>
</body>
</html>