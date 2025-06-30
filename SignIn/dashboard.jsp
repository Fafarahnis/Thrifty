<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This page expects data from a DashboardServlet:
  - User object from session: ${sessionScope.user}
  - Stats object: ${dashboardStats} (containing totalRentals, upcomingTripCount, rewardPoints)
  - List of recent bookings: ${recentBookings}
  - List of upcoming trips: ${upcomingTrips}
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Dashboard | CarRental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    
    <style>
      :root {
        --primary-color: #3498db;
        --secondary-color: #e6a046;
        --success-color: #2ecc71;
        --warning-color: #f39c12;
        --danger-color: #e74c3c;
      }
      body { font-family: "Outfit", sans-serif; background-color: #f5f7fa; }
      .dashboard-header { background: url('<c:url value="/images/dashboardbg.png"/>') center/cover; color: white; padding: 2rem 0; border-radius: 0 0 10px 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); margin-bottom: 2rem; }
      .welcome-message { font-size: 1.8rem; font-weight: 600; }
      .stats-card { background: #fffdf1; border-radius: 10px; padding: 1.5rem; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border-left: 4px solid var(--secondary-color); }
      .stat-number { font-size: 2.5rem; font-weight: 700; color: var(--secondary-color); }
      .card { border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 2rem; }
      .card-header { background-color: white; border-bottom: 1px solid rgba(0,0,0,0.05); font-weight: 600; }
      .booking-card { border-left: 4px solid var(--success-color); }
      .upcoming-card { border-left: 4px solid var(--warning-color); }
      .status-badge { padding: 0.35rem 0.75rem; border-radius: 50px; font-size: 0.8rem; }
      .status-complete { background-color: rgba(46, 204, 113, 0.1); color: var(--success-color); }
      .status-upcoming { background-color: rgba(243, 156, 18, 0.1); color: var(--warning-color); }
      .btn-action { border-radius: 50px; padding: 0.5rem 1.25rem; font-weight: 500; }
      .car-image { width: 80px; height: 60px; object-fit: cover; border-radius: 8px; }
      .quick-actions { display: flex; gap: 1rem; margin-bottom: 2rem; }
      .quick-action-btn { flex: 1; padding: 1rem; text-align: center; background: white; border-radius: 10px; box-shadow: 0 2px 5px rgb(0 0 0 / 42%); transition: all 0.3s ease; color: #333; text-decoration: none;}
      .quick-action-btn:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
      .quick-action-icon { font-size: 1.5rem; margin-bottom: 0.5rem; color: var(--secondary-color); }
    </style>
</head>

<body>
    <div class="site-wrap" id="home-section">
        <jsp:include page="navbarSI.jsp" />

        <div class="container py-4">
            <!-- Dashboard Header -->
            <div class="dashboard-header mb-5" >
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h1 class="welcome-message" style="color: white;">Welcome back, ${sessionScope.user.firstName}!</h1>
                            <p class="mb-0">Here's a summary of your rental activity.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="<c:url value='/carList.jsp'/>" class="quick-action-btn">
                    <div class="quick-action-icon"><i class="fas fa-car"></i></div>
                    <div>Book a Car</div>
                </a>
                <a href="<c:url value='/profile.jsp'/>" class="quick-action-btn">
                    <div class="quick-action-icon"><i class="fas fa-history"></i></div>
                    <div>Rental History</div>
                </a>
                <a href="#" class="quick-action-btn">
                    <div class="quick-action-icon"><i class="fas fa-star"></i></div>
                    <div>My Rewards</div>
                </a>
                <a href="<c:url value='/profile.jsp'/>" class="quick-action-btn">
                    <div class="quick-action-icon"><i class="fas fa-cog"></i></div>
                    <div>Settings</div>
                </a>
            </div>
            
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="stats-card h-100">
                        <div class="stat-number">${dashboardStats.totalRentals}</div>
                        <div class="stat-label">Total Rentals</div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card h-100">
                        <div class="stat-number">${dashboardStats.upcomingTripCount}</div>
                        <div class="stat-label">Upcoming Trips</div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card h-100">
                        <div class="stat-number">${dashboardStats.rewardPoints}</div>
                        <div class="stat-label">Reward Points</div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <!-- Recent Bookings -->
                <div class="col-lg-8 mb-4">
                    <div class="card booking-card h-100">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Recent Bookings</span>
                            <a href="<c:url value='/profile.jsp'/>" class="btn btn-sm btn-outline-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Car</th>
                                            <th>Dates</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="booking" items="${recentBookings}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="<c:url value='/images/${booking.car.imageFileName}'/>" alt="${booking.car.model}" class="car-image me-3">
                                                        <div>
                                                            <strong>${booking.car.model}</strong><br>
                                                            <small class="text-muted">${booking.car.type} • ${booking.car.transmission}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${booking.formattedStartDate} - ${booking.formattedEndDate}</td>
                                                <td><span class="status-badge status-complete">Completed</span></td>
                                                <td>
                                                    <a href="<c:url value='/review?bookingId=${booking.id}'/>" class="btn btn-sm btn-action btn-outline-primary"><i class="fas fa-star me-1"></i> Review</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty recentBookings}">
                                             <tr><td colspan="4" class="text-center p-4">You have no recent bookings.</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Upcoming Trips -->
                <div class="col-lg-4 mb-4">
                    <div class="card upcoming-card h-100">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Upcoming Trips</span>
                        </div>
                        <div class="card-body">
                            <c:forEach var="booking" items="${upcomingTrips}">
                                <div class="mb-4">
                                    <div class="d-flex mb-3">
                                        <img src="<c:url value='/images/${booking.car.imageFileName}'/>" alt="${booking.car.model}" class="car-image me-3">
                                        <div>
                                            <strong>${booking.car.model}</strong><br>
                                            <small class="text-muted">${booking.formattedStartDate} - ${booking.formattedEndDate}</small><br>
                                            <span class="status-badge status-upcoming">Upcoming</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <a href="<c:url value='/modifyBooking?id=${booking.id}'/>" class="btn btn-sm btn-action btn-warning"><i class="fas fa-edit me-1"></i> Modify</a>
                                        <a href="<c:url value='/cancelBooking?id=${booking.id}'/>" class="btn btn-sm btn-action btn-danger"><i class="fas fa-times me-1"></i> Cancel</a>
                                    </div>
                                </div>
                                <hr>
                            </c:forEach>
                             <c:if test="${empty upcomingTrips}">
                                <div class="text-center p-4">
                                    <p>You have no upcoming trips.</p>
                                </div>
                            </c:if>
                            <div class="text-center">
                                <a href="<c:url value='/carList.jsp'/>" class="btn btn-action btn-primary">
                                    <i class="fas fa-plus me-1"></i> Book Another Car
                                </a>
                            </div>
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
    <script src="<c:url value='/js/main.js'/>"></script>
</body>
</html>