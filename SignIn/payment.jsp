<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This page expects a 'bookingSummary' object from a servlet.
  The servlet would have calculated rental days, costs, and taxes.

  Example in Servlet:
  BookingSummary summary = bookingService.createSummary(bookingDetails);
  request.setAttribute("bookingSummary", summary);
  request.getRequestDispatcher("/payment.jsp").forward(request, response);
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Payment - Thrifty Car Rental</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
      .tcr-payment-container { max-width: 1100px; margin: 2rem auto; }
      .tcr-booking-card, .tcr-payment-section { background: white; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); padding: 2rem; }
      .tcr-total-price { font-size: 1.5rem; font-weight: bold; border-top: 2px solid #343a40; padding-top: 1rem; margin-top: 1rem; }
      .tcr-btn-pay { width: 100%; padding: 1rem; font-size: 1.1rem; font-weight: bold; }
    </style>
</head>
<body>
    <jsp:include page="navbarSI.jsp" />

    <div class="container tcr-payment-container">
        <div class="row g-4">
            <!-- Booking Summary Column -->
            <div class="col-lg-5">
                <div class="tcr-booking-card">
                    <div class="d-flex align-items-center gap-3 border-bottom pb-3">
                        <img src="<c:url value='/images/${bookingSummary.car.imageFileName}'/>" alt="${bookingSummary.car.title}" style="width: 100px; border-radius: 5px;">
                        <div>
                            <h2 class="h4 mb-0">${bookingSummary.car.title}</h2>
                            <p class="text-muted mb-0">${bookingSummary.car.type}</p>
                        </div>
                    </div>
                    
                    <div class="my-4">
                        <div class="d-flex justify-content-between mb-2"><span>Pickup Date:</span><strong>${bookingSummary.pickupDate}</strong></div>
                        <div class="d-flex justify-content-between mb-2"><span>Return Date:</span><strong>${bookingSummary.returnDate}</strong></div>
                        <div class="d-flex justify-content-between"><span>Rental Duration:</span><strong>${bookingSummary.rentalDays} day(s)</strong></div>
                    </div>
                    
                    <div class="my-4">
                        <div class="d-flex justify-content-between">
                            <span>Rental Rate (${bookingSummary.rentalDays} x $<fmt:formatNumber value="${bookingSummary.car.pricePerDay}" minFractionDigits="2"/>):</span>
                            <span>$<fmt:formatNumber value="${bookingSummary.subtotal}" minFractionDigits="2"/></span>
                        </div>
                        <div class="d-flex justify-content-between"><span>Taxes & Fees:</span><span>$<fmt:formatNumber value="${bookingSummary.taxes}" minFractionDigits="2"/></span></div>
                    </div>

                    <div class="tcr-total-price d-flex justify-content-between">
                        <span>Total:</span>
                        <span>$<fmt:formatNumber value="${bookingSummary.totalPrice}" minFractionDigits="2"/></span>
                    </div>
                </div>
            </div>

            <!-- Payment Method Column -->
            <div class="col-lg-7">
                <div class="tcr-payment-section">
                    <h2 class="h3">Payment Method</h2>
                    <p>Enter your payment details to complete the booking.</p>
                    
                    <%-- This form submits all data to the final processing servlet --%>
                    <form id="payment-form" action="<c:url value='/processPayment'/>" method="POST">
                        <%-- Hidden fields to pass booking data to the next servlet --%>
                        <input type="hidden" name="bookingId" value="${bookingSummary.id}">
                        <input type="hidden" name="totalAmount" value="${bookingSummary.totalPrice}">

                        <div class="mb-3">
                            <label for="cardholderName" class="form-label">Cardholder Name</label>
                            <input type="text" id="cardholderName" name="cardholderName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="cardNumber" class="form-label">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" class="form-control" placeholder="•••• •••• •••• ••••" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="expiryDate" class="form-label">Expiry Date</label>
                                <input type="text" id="expiryDate" name="expiryDate" class="form-control" placeholder="MM/YY" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="text" id="cvv" name="cvv" class="form-control" placeholder="123" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary tcr-btn-pay">
                            <i class="fas fa-lock"></i> Pay $<fmt:formatNumber value="${bookingSummary.totalPrice}" minFractionDigits="2"/>
                        </button>
                        <p class="text-center text-muted mt-3"><i class="fas fa-shield-alt"></i> Your payment is securely processed.</p>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
    
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>