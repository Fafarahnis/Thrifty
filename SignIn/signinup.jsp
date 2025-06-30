<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%
    // Check if user is logged in
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("signinup.jsp");
        return;
    }%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="form-container sign-in-container">
    <form action="${pageContext.request.contextPath}/login" method="POST">
        <%-- Login fields --%>
        <c:if test="${not empty loginError}">
            <p style="color:red; font-size:12px;">${loginError}</p>
        </c:if>
        <button type="submit">Sign In</button>
    </form>
</div>
<div class="form-container sign-up-container">
    <form action="${pageContext.request.contextPath}/register" method="POST">
        <%-- Registration fields --%>
        <c:if test="${not empty registerError}">
            <p style="color:red; font-size:12px;">${registerError}</p>
        </c:if>
        <c:if test="${param.registration == 'success'}">
            <p style="color:green; font-size:12px;">Registration successful! Please sign in.</p>
        </c:if>
        <button type="submit">Sign Up</button>
    </form>
</div>

</body>
</html>