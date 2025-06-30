<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<footer class="site-footer">
    <div class="container">
      <div class="row">
        <div class="col-lg-3">
          <h2 class="footer-heading mb-4">About Us</h2>
          <p>Locally owned and globally trusted, Thrifty is committed to making car rental easy, fast, and enjoyable for everyone.</p>
        </div>
        <div class="col-lg-8 ml-auto">
          <div class="row">
            <div class="col-lg-4">
              <h2 class="footer-heading mb-4">Quick Links</h2>
              <ul class="list-unstyled">
                <li><a href="<c:url value='/about.jsp'/>">About Us</a></li>
                <li><a href="<c:url value='/carList_public.jsp'/>">Car Listings</a></li>
                <li><a href="<c:url value='/reviews.jsp'/>">Reviews</a></li>
              </ul>
            </div>
            <div class="col-lg-4">
              <h2 class="footer-heading mb-4">Support</h2>
              <ul class="list-unstyled">
                <li><a href="<c:url value='/faq.jsp'/>">FAQ</a></li>
                <li><a href="<c:url value='/contact_public.jsp'/>">Help Center</a></li>
              </ul>
            </div>
            <div class="col-lg-4">
              <h2 class="footer-heading mb-4">Contact Info</h2>
              <ul class="list-unstyled">
                  <li class="mb-3">Jasin, Melaka</li>
                  <li class="mb-3">+60 0194357257</li>
                  <li class="mb-3">info@ythrifty.com</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="row pt-5 mt-5 text-center">
        <div class="col-md-12"><div class="border-top pt-5"><p>Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved</p></div></div>
      </div>
    </div>
</footer>