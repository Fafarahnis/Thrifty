<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Profile - CarRental</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/fonts/icomoon/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <%-- YOUR ORIGINAL CSS LAYOUT - UNCHANGED --%>
    <style>
        .profile-hero { background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('<c:url value="/images/hero_1_a.jpg"/>'); background-size: cover; padding: 100px 0; color: white; }
        .profile-card { border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); position: relative; z-index: 2; }
        /* Adjusted to apply to the content container, not the background page */
        .main-content-container { margin-top: -50px; }
        .profile-avatar { width: 120px; height: 120px; object-fit: cover; border-radius: 50%; border: 5px solid white; margin-top: -60px; }
        .license-preview { max-width: 100%; height: 200px; object-fit: contain; border: 1px solid #ddd; border-radius: 5px; display: none; }
        .edit-btn { position: absolute; top: 15px; right: 15px; }
        .rental-history-item { border-left: 3px solid #e6a046; transition: all 0.3s ease; }
        .rental-history-item:hover { background-color: #f8f9fa; transform: translateX(5px); }
        .file-upload { position: relative; overflow: hidden; }
        .file-upload-input { position: absolute; left: 0; top: 0; opacity: 0; width: 100%; height: 100%; cursor: pointer; }
    </style>
</head>
<body>
    <div class="site-wrap">
        <%-- Replaced JS fetch with server-side include --%>
        <jsp:include page="navbarSI.jsp" />

        <div class="background-page">
            <div class="container">
                <div class="row align-items-end"><div class="col-lg-5"><div class="intro"><h1><strong>My Profile</strong></h1><div class="custom-breadcrumbs"><a href="<c:url value='/dashboard.jsp'/>">Home</a><span class="mx-2">/</span><strong>Profile</strong></div></div></div></div>
            </div>
        </div>

        <%-- Main content container to apply the negative margin for the overlap effect --%>
        <div class="container main-content-container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="profile-card bg-white p-4 mb-4">
                        <div class="text-center">
                            <c:choose>
                                <c:when test="${not empty user.avatarFileName}"><img src="<c:url value='/images/avatars/${user.avatarFileName}'/>" alt="Profile Photo" class="profile-avatar mb-3" id="profile-avatar"></c:when>
                                <c:otherwise><img src="<c:url value='/images/default-avatar.jpg'/>" alt="Profile Photo" class="profile-avatar mb-3" id="profile-avatar"></c:otherwise>
                            </c:choose>
                            <h3 id="profile-name">${user.firstName} ${user.lastName}</h3>
                            <p class="text-muted" id="profile-email">${user.email}</p>
                            
                            <form action="<c:url value='/uploadAvatar'/>" method="post" enctype="multipart/form-data">
                                <div class="file-upload btn btn-primary btn-sm mt-2">
                                    <span>Change Photo</span>
                                    <input type="file" name="avatar" class="file-upload-input" id="avatar-upload" accept="image/*" onchange="this.form.submit()">
                                </div>
                            </form>
                        </div>
                        <hr class="my-4">
                        <h5 class="mb-3">Driver's License</h5>
                        <div class="text-center mb-3">
                            <img src="<c:url value='/images/licenses/${user.licenseFileName}'/>" alt="License Preview" class="license-preview mb-2" id="license-preview" style="${not empty user.licenseFileName ? 'display:block;' : 'display:none;'}">
                            <form action="<c:url value='/uploadLicense'/>" method="post" enctype="multipart/form-data">
                                <div class="file-upload btn btn-outline-primary btn-sm">
                                    <span id="license-text">${not empty user.licenseFileName ? 'Change License' : 'Upload License'}</span>
                                    <input type="file" name="license" class="file-upload-input" id="license-upload" accept="image/*,.pdf" onchange="this.form.submit()">
                                </div>
                            </form>
                            <small class="d-block text-muted mt-2">JPEG, PNG or PDF (Max 5MB)</small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-8">
                    <div class="profile-card bg-white p-4 mb-4">
                        <button class="btn btn-sm btn-outline-primary edit-btn" id="edit-profile-btn"><i class="far fa-edit"></i> Edit</button>
                        <h3 class="mb-4">Personal Information</h3>
                        <form id="profile-form" action="<c:url value='/updateProfile'/>" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3"><label class="form-label">First Name</label><input type="text" class="form-control" name="firstName" id="first-name" value="${user.firstName}" readonly></div>
                                <div class="col-md-6 mb-3"><label class="form-label">Last Name</label><input type="text" class="form-control" name="lastName" id="last-name" value="${user.lastName}" readonly></div>
                            </div>
                            <div class="mb-3"><label class="form-label">Email</label><input type="email" class="form-control" name="email" id="email" value="${user.email}" readonly></div>
                            <div class="row">
                                <div class="col-md-6 mb-3"><label class="form-label">Phone</label><input type="tel" class="form-control" name="phone" id="phone" value="${user.phone}" readonly></div>
                                <div class="col-md-6 mb-3"><label class="form-label">Date of Birth</label><input type="date" class="form-control" name="dob" id="dob" value="${user.dob}" readonly></div>
                            </div>
                            <div class="d-flex justify-content-end mt-4">
                                <button type="button" class="btn btn-outline-secondary me-2" id="cancel-edit" style="display: none;">Cancel</button>
                                <button type="submit" class="btn btn-primary" id="save-profile" style="display: none;">Save Changes</button>
                            </div>
                        </form>
                    </div>
                    
                    <div class="profile-card bg-white p-4" id="rental-history">
                        <h3 class="mb-4">Rental History</h3>
                        <c:forEach var="booking" items="${rentalHistory}">
                            <div class="rental-history-item p-3 mb-3"><div class="d-flex justify-content-between"><div><h5 class="mb-1">${booking.car.model}</h5><p class="text-muted mb-1">${booking.formattedStartDate} - ${booking.formattedEndDate}</p><span class="badge bg-success">Completed</span></div><div class="text-end"><p class="mb-1">$<fmt:formatNumber value="${booking.totalPrice}" minFractionDigits="2"/></p><a href="<c:url value='/bookingDetails?id=${booking.id}'/>" class="btn btn-sm btn-outline-primary">View Details</a></div></div></div>
                        </c:forEach>
                        <c:if test="${empty rentalHistory}"><p>You have no past rentals.</p></c:if>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </div>

    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
    
    <%-- YOUR ORIGINAL JAVASCRIPT - UNCHANGED, FOR UI INTERACTIVITY --%>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Edit Profile Toggle Logic
        const editBtn = document.getElementById('edit-profile-btn');
        const cancelBtn = document.getElementById('cancel-edit');
        const saveBtn = document.getElementById('save-profile');
        const formInputs = document.querySelectorAll('#profile-form input');
        
        editBtn.addEventListener('click', function() {
            formInputs.forEach(input => {
                input.readOnly = false;
                input.classList.add('bg-light');
            });
            editBtn.style.display = 'none';
            cancelBtn.style.display = 'block';
            saveBtn.style.display = 'block';
        });
        
        cancelBtn.addEventListener('click', function() {
            // Simply reloads the page to cancel changes. Backend data will repopulate original values.
            window.location.reload();
        });
    });
    </script>
</body>
</html>