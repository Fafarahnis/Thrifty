<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Sign In / Sign Up - Thrifty Car Rental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/auth.css'/>"> <%-- Specific CSS for this page --%>
    <style>
        /* Small helper style for the referral info text */
        .referral-info {
            font-size: 12px;
            color: #888;
            margin-top: -5px; /* Pull it closer to the input field */
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="navbarSU.jsp" />
    <main><br><br><br><br><br>
        <div class="auth-page-container">
            <div class="container" id="container">
                <div class="form-container sign-up-container">
                    <form action="<c:url value='/register'/>" method="POST">
                        <h1>Create Account</h1>
                        
                        <c:if test="${not empty registerError}">
                            <p style="color: red; font-size: 14px;">${registerError}</p>
                        </c:if>

                        <input type="text" name="name" placeholder="Name" required />
                        <input type="email" name="email" placeholder="Email" required />
                        <input type="password" name="password" placeholder="Password" required />
                        
                        <%-- THIS IS THE NEW REFERENTIAL (REFERRAL) CODE PART --%>
						<p class="referral-info">Have a code? Enter it to get 50 bonus points!</p>
                        <input type="text" name="referralCode" placeholder="Referral Code (Optional)" />
                        <%-- ======================================================= --%>

                        <button type="submit">Sign Up</button>
                    </form>
                </div>
                <div class="form-container sign-in-container">
                    <form action="<c:url value='/login'/>" method="POST">
                        <h1>Sign In</h1>
                        <c:if test="${not empty loginError}">
                            <p style="color: red; font-size: 14px;">${loginError}</p>
                        </c:if>
                        <input type="email" name="email" placeholder="Email" required />
                        <input type="password" name="password" placeholder="Password" required />
                        <a href="#">Forgot your password?</a>
                        <button type="submit">Sign In</button>
                    </form>
                </div>
                <div class="overlay-container">
                    <div class="overlay">
                        <div class="overlay-panel overlay-left">
                            <h1>Welcome Back!</h1>
                            <p>To keep connected with us please login with your personal info</p>
                            <button class="ghost" id="signIn">Sign In</button>
                        </div>
                        <div class="overlay-panel overlay-right">
                            <h1>Hello, Friend!</h1>
                            <p>Enter your personal details and start your journey with us</p>
                            <button class="ghost" id="signUp">Sign Up</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const signUpButton = document.getElementById('signUp');
            const signInButton = document.getElementById('signIn');
            const container = document.getElementById('container');
            if (signUpButton) signUpButton.addEventListener('click', () => container.classList.add("right-panel-active"));
            if (signInButton) signInButton.addEventListener('click', () => container.classList.remove("right-panel-active"));
        });
    </script>
</body>
</html>