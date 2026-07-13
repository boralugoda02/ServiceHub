<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="header.jsp" %>
    <title>My Earnings</title>
</head>
<body class="bg-light p-4">
    <div class="container">
        <h3>Earnings Dashboard</h3>
        <div class="row mt-4">
            <div class="col-md-4"><div class="card p-3 bg-primary text-white"><h5>Total Earned</h5><h3>LKR 45,000</h3></div></div>
            <div class="col-md-4"><div class="card p-3 bg-success text-white"><h5>This Month</h5><h3>LKR 12,000</h3></div></div>
        </div>
        
        <h5 class="mt-4">Payment History</h5>
        <ul class="list-group">
            <li class="list-group-item d-flex justify-content-between">
                <span>AC Repair (Job #101)</span>
                <span class="fw-bold text-success">+ LKR 3,000</span>
            </li>
        </ul>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init(); // Initialize AOS animations
</script>
</body>
</html>