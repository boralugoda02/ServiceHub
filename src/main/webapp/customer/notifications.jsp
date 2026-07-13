<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
    <title>Notifications</title>
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="card notif-card p-4">
            <h4 class="fw-bold mb-4"><i class="fas fa-bell text-primary"></i> Notifications</h4>
            
            <ul class="list-group list-group-flush">
                <li class="list-group-item d-flex align-items-center">
                    <div class="icon-box bg-primary text-white"><i class="fas fa-briefcase"></i></div>
                    <div>
                        <h6 class="mb-1">New Job Request</h6>
                        <small class="text-muted">You have a new painting request from Nimal.</small>
                    </div>
                </li>

                <li class="list-group-item d-flex align-items-center">
                    <div class="icon-box bg-success text-white"><i class="fas fa-check-circle"></i></div>
                    <div>
                        <h6 class="mb-1">Booking Accepted</h6>
                        <small class="text-muted">Your booking for Plumbing Service has been accepted by John.</small>
                    </div>
                </li>

                <li class="list-group-item d-flex align-items-center">
                    <div class="icon-box bg-danger text-white"><i class="fas fa-times-circle"></i></div>
                    <div>
                        <h6 class="mb-1">Booking Cancelled</h6>
                        <small class="text-muted">Sorry, the Electrician cancelled your request due to an emergency.</small>
                    </div>
                </li>

                <li class="list-group-item d-flex align-items-center">
                    <div class="icon-box bg-warning text-white"><i class="fas fa-star"></i></div>
                    <div>
                        <h6 class="mb-1">Review Reminder</h6>
                        <small class="text-muted">How was your recent Car Wash service? Please rate it.</small>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init(); // Initialize AOS animations
</script>
</body>
</html>