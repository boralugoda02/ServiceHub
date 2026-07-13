<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../header.jsp" %>
    <title>My Earnings</title>
</head>
<body>
    <jsp:include page="../common/sidebar.jsp" />
    <div class="main-content">
        <div class="container-fluid">
            <h3 class="fw-bold mb-4">Earnings Dashboard</h3>
            <div class="row mt-4 g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="card p-4 bg-primary text-white border-0 shadow-sm rounded-3">
                        <h5 class="text-white-50">Total Earned</h5>
                        <h2 class="fw-bold mb-0">LKR 45,000</h2>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="card p-4 bg-success text-white border-0 shadow-sm rounded-3">
                        <h5 class="text-white-50">This Month</h5>
                        <h2 class="fw-bold mb-0">LKR 12,000</h2>
                    </div>
                </div>
            </div>
            
            <div class="card p-4 shadow-sm bg-white mt-4 border-0 rounded-3">
                <h5 class="fw-bold text-dark mb-3">Payment History</h5>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3">
                        <div>
                            <h6 class="mb-0 fw-semibold text-dark">AC Repair</h6>
                            <small class="text-muted">Job #101</small>
                        </div>
                        <span class="fw-bold text-success fs-5">+ LKR 3,000</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init(); // Initialize AOS animations
    </script>
</body>
</html>