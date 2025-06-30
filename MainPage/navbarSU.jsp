<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/fonts/icomoon/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/other.css'/>">
    <style>
        .custom-btn { background-color: #e6a046; color: white; border: none; padding: 12px 25px; }
        .custom-btn:hover { background-color: #dfb465; }
    </style>
</head>
<header class="site-navbar site-navbar-target" role="banner" style="position: sticky; top: 0; width: 100%; z-index: 1000; background-color: rgba(255, 255, 255, 0.95); box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <div class="container-1">
        <div class="row align-items-center position-relative">
            <div class="col-3">
                <div class="site-logo">
                    <a href="<c:url value='/home.jsp'/>" class="d-flex align-items-center text-decoration-none text-dark text-nowrap font1">
                        <img src="<c:url value='/images/logo.png'/>" alt="Logo" class="img-fluid" style="width:170px;">
                        <span class="ml-2">Thrifty Car Rental</span>
                    </a>
                </div>
            </div>
            <div class="col-9 text-right" style="padding-right: 10%;">
                <span class="d-inline-block d-lg-none"><a href="#" class="site-menu-toggle js-menu-toggle py-5"><span class="icon-menu h3 text-black"></span></a></span>
                <nav class="site-navigation text-right ml-auto d-none d-lg-block" role="navigation">
                    <ul class="site-menu main-menu js-clone-nav ml-auto">
                        <li><a href="<c:url value='home.jsp'/>" class="nav-link">Home</a></li>
                        <li><a href="<c:url value='carList_public.jsp'/>" class="nav-link">Car List</a></li>
                        <li><a href="<c:url value='reviews.jsp'/>" class="nav-link">Reviews</a></li>
                        <li><a href="<c:url value='about.jsp'/>" class="nav-link">About Us</a></li>
                        <li><a href="<c:url value='contact.jsp'/>" class="nav-link">Contact Us</a></li>
                        <li><a href="<c:url value='faq.jsp'/>" class="nav-link">FAQ</a></li>
                        <li><a href="<c:url value='signinup.jsp'/>" class="btn custom-btn ms-3">Sign In</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</header>