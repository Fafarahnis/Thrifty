<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- This gets the current page name, e.g., "dashboard.jsp" --%>
<c:set var="currentPage" value="${pageContext.request.servletPath.substring(pageContext.request.servletPath.lastIndexOf('/') + 1)}" />

<!-- Sidebar -->
<div class="sidebar" data-background-color="dark">
    <div class="sidebar-logo">
        <div class="logo-header" data-background-color="dark">
            <a href="<c:url value='/admin/dashboard'/>" class="logo">
                <img src="<c:url value='/assets/img/logoHitamThrifty1.png'/>" alt="navbar brand" class="navbar-brand" height="60"/>
            </a>
            <!-- ... toggler buttons ... -->
        </div>
    </div>
    <div class="sidebar-wrapper scrollbar scrollbar-inner">
        <div class="sidebar-content">
            <ul class="nav nav-secondary">
                <li class="nav-item <c:if test='${currentPage == "dashboard.jsp"}'>active</c:if>">
                    <a href="<c:url value='/admin/dashboard'/>">
                        <i class="fas fa-home"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li class="nav-section">
                    <span class="sidebar-mini-icon"><i class="fa fa-ellipsis-h"></i></span>
                    <h4 class="text-section">Components</h4>
                </li>
                
                <li class="nav-item <c:if test='${currentPage.contains("forms") || currentPage.contains("view.jsp") }'>active submenu</c:if>">
                    <a data-bs-toggle="collapse" href="#forms"><i class="fas fa-user"></i><p>Account</p><span class="caret"></span></a>
                    <div class="collapse" id="forms">
                        <ul class="nav nav-collapse">
                            <li><a href="<c:url value='/admin/account?action=add'/>"><span class="sub-item">Create Admin Account</span></a></li>
                            <li><a href="<c:url value='/admin/account?action=list'/>"><span class="sub-item">View Account</span></a></li>
                            <li><a href="<c:url value='/admin/account?action=deleteList'/>"><span class="sub-item">Delete Account</span></a></li>
                        </ul>
                    </div>
                </li>

                <!-- Car Menu -->
                <li class="nav-item <c:if test='${currentPage.contains("-car")}'>active submenu</c:if>">
                    <a data-bs-toggle="collapse" href="#carMenu"><i class="fas fa-car"></i><p>Car</p><span class="caret"></span></a>
                    <div class="collapse" id="carMenu">
                        <ul class="nav nav-collapse">
                            <li><a href="<c:url value='/admin/cars?action=add'/>"><span class="sub-item">Add Car</span></a></li>
                            <li><a href="<c:url value='/admin/cars?action=list'/>"><span class="sub-item">View Car</span></a></li>
                        </ul>
                    </div>
                </li>

                <!-- Booking Menu -->
                <li class="nav-item <c:if test='${currentPage.contains("-booking") || currentPage.contains("supervision")}'>active submenu</c:if>">
                    <a data-bs-toggle="collapse" href="#bookingMenu"><i class="fas fa-layer-group"></i><p>Booking</p><span class="caret"></span></a>
                    <div class="collapse" id="bookingMenu">
                        <ul class="nav nav-collapse">
                            <li><a href="<c:url value='/admin/bookings?action=pending'/>"><span class="sub-item">Approve Booking</span></a></li>
                            <li><a href="<c:url value='/admin/bookings?action=list'/>"><span class="sub-item">View All Bookings</span></a></li>
                            <li><a href="<c:url value='/admin/bookings?action=supervise'/>"><span class="sub-item">Rental Supervision</span></a></li>
                        </ul>
                    </div>
                </li>

                <li class="nav-item <c:if test='${currentPage.contains("-review")}'>active</c:if>">
                    <a href="<c:url value='/admin/reviews?action=list'/>">
                        <i class="fas fa-star"></i><p>Review</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- End Sidebar -->

<div class="main-header">
    <!-- Top Navbar goes here... use sessionScope to display admin name -->
    <span class="fw-bold">${sessionScope.admin.adminName}</span>
    <a class="dropdown-item" href="<c:url value='/logout'/>">Logout</a>
</div>