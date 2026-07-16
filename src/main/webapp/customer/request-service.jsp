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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Service - ServiceHub</title>
    <%@include file="../header.jsp" %>
    <style>
        .form-card { background: white; border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.04); padding: 30px; }
    </style>
</head>
<body>
    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <div class="container-fluid">
            <h2 class="fw-bold text-dark mb-4">Request a New Service</h2>
            <div class="card form-card">
                <form action="../BookingServlet" method="POST">
    <input type="hidden" name="action" value="createRequest">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">District</label>
                                <input type="text" name="district" class="form-control" placeholder="District name..." required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">City</label>
                                 <input type="text" name="city" class="form-control" placeholder="City name..." required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold"> Address</label>
                                <input type="text" name="address" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Service Date</label>
                                <input type="date" name="serviceDate" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Service Time</label>
                                 <input type="time" name="serviceTime" class="form-control" required>
                         </div>
                        <div class="col-12 d-grid mt-4">
                            <button type="submit" class="btn btn-primary py-2 fw-semibold">Submit Request</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>