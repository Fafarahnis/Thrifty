<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  This component will be included in other pages.
  It assumes user information is stored in the session.
  e.g., A servlet would do: session.setAttribute("user", userObject);
--%>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/fonts/icomoon/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/other.css'/>">
    <style>
        /* Profile Dropdown Styles */
        .profile-dropdown {
            position: relative;
            display: inline-block;
            margin-left: 15px;
        }

        .profile-dropdown .dropdown-toggle {
            display: flex;
            align-items: center;
            color: #333;
            border: 1px solid #ddd;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .profile-dropdown .dropdown-toggle:hover {
            background-color: #f8f9fa;
            border-color: #ccc;
        }

        .profile-dropdown .dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            top: 100%;
            min-width: 200px;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: 1px solid #ddd;
            border-radius: 4px;
            z-index: 1000;
            padding: 5px 0;
            margin-top: 5px;
        }

        .profile-dropdown:hover .dropdown-menu,
        .profile-dropdown:focus-within .dropdown-menu {
            display: block;
        }

        .dropdown-menu li {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        .dropdown-menu a {
            display: block;
            padding: 8px 20px;
            color: #333;
            white-space: nowrap;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 14px;
        }

        .dropdown-menu a:hover {
            background-color: #f8f9fa;
            color: #007bff;
        }

        .dropdown-divider {
            height: 1px;
            margin: 5px 0;
            background: #e9ecef;
        }

        .logout-btn {
            color: #dc3545 !important;
        }

        .logout-btn:hover {
            background: #f8d7da !important;
        }

        .profile-icon {
            margin-right: 8px;
            font-size: 16px;
        }
        
    </style>
</head>
<header class="site-navbar site-navbar-target" role="banner" style="position: sticky; top: 0; width: 100%; z-index: 1000; background-color: rgb(185 185 174); box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <div class="container-1">
        <div class="row align-items-center position-relative">
            <div class="col-3">
                <div class="site-logo">
                    <a href="<c:url value='/dashboard.jsp'/>" class="d-flex align-items-center text-decoration-none text-dark text-nowrap font1">
                        <img src="<c:url value='/images/logo.png'/>" alt="Logo" class="img-fluid" style="width:170px; height: auto;">
                        <span class="ml-2">Thrifty Car Rental</span>
                    </a>
                </div>
            </div>
            <div class="col-9 text-right" style="padding-right: 10%;">
                <span class="d-inline-block d-lg-none"><a href="#" class="site-menu-toggle js-menu-toggle py-5"><span class="icon-menu h3 text-black"></span></a></span>
                <nav class="site-navigation text-right ml-auto d-none d-lg-block" role="navigation">
                    <ul class="site-menu main-menu js-clone-nav ml-auto">
                        <li><a href="<c:url value='dashboard.jsp'/>" class="nav-link">Home</a></li>
                        <li><a href="<c:url value='carList.jsp'/>" class="nav-link">Car List</a></li>
                        <li><a href="<c:url value='contact.jsp'/>" class="nav-link">Contact Us</a></li>
                        <li><a href="<c:url value='faq.jsp'/>" class="nav-link">FAQ</a></li>
                        <li class="profile-dropdown">
                            <button class="dropdown-toggle">
                                <span class="profile-icon">👤</span>
                                <%-- JSTL Placeholder for user's name from session --%>
                                <span class="user-name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value='profile.jsp'/>">Profile</a></li>
                                <li><a href="<c:url value='orders.jsp'/>">Booking History</a></li>
                                <li class="dropdown-divider"></li>
                                <%-- Link to a logout servlet --%>
                                <li><a href="<c:url value='/logout'/>" class="logout-btn">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</header>