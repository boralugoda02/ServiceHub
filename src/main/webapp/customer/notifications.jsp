<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Integer customerId = (Integer) session.getAttribute("customerId");
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "Customer";
    if (customerId == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notifications - ServiceHub</title>
    <%@include file="../header.jsp" %>
    <style>
        .noti-card { background: white; border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.02); padding: 20px; margin-bottom: 15px; border-left: 5px solid #007bff; }
    </style>
</head>
<body>
    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <div class="container-fluid">
            <h2 class="fw-bold text-dark mb-4">Notifications</h2>
            <div class="noti-card">
                <div class="d-flex justify-content-between">
                    <h6 class="fw-bold text-dark mb-1">Welcome to ServiceHub!</h6>
                    <small class="text-muted">Just now</small>
                </div>
                <p class="text-muted mb-0">Your customer dashboard account is fully activated. You can now request services easily.</p>
            </div>
        </div>
    </div>
</body>
</html>