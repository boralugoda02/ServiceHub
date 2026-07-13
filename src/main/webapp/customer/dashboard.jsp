<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session Validation: Ensure user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=UnauthorizedAccess");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="../header.jsp" %>
    <title>Dashboard - ServiceHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        .profile-img { width: 70px; height: 70px; background-color: #007bff; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.8rem; font-weight: bold; margin: 0 auto 10px; }
        .card { border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.04); background: #ffffff; }
    </style>
</head>
<body>

    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <h3 class="fw-bold text-dark">Dashboard Overview</h3>
        <p class="text-muted">Welcome back, ${sessionScope.user.fullName}! Here is your overview.</p>

        <div class="row mt-4 g-3">
            <div class="col-md-3"><div class="card p-3"><p class="text-muted mb-1">Jobs Done</p><h4 class="fw-bold">12</h4></div></div>
            <div class="col-md-3"><div class="card p-3"><p class="text-muted mb-1">Active</p><h4 class="fw-bold">3</h4></div></div>
            <div class="col-md-3"><div class="card p-3"><p class="text-muted mb-1">Pending</p><h4 class="fw-bold">2</h4></div></div>
            <div class="col-md-3"><div class="card p-3"><p class="text-muted mb-1">Rating</p><h4 class="fw-bold">4.8 / 5.0</h4></div></div>
        </div>

        <div class="row mt-4 g-4">
            <div class="col-md-8">
                <div class="card p-4">
                    <h5 class="fw-bold mb-3">Recent Jobs</h5>
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light"><tr><th>Job</th><th>Status</th></tr></thead>
                        <tbody><tr><td>House Painting</td><td><span class="badge bg-success px-3 py-2 rounded-pill">Done</span></td></tr></tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4">
                    <h5 class="fw-bold mb-3">Quick Actions</h5>
                    <div class="d-grid gap-2 mt-2">
                        <a href="${pageContext.request.contextPath}/customer/request-service.jsp" class="btn btn-primary py-2 fw-semibold">Post New Job</a>
                        <a href="${pageContext.request.contextPath}/customer/profile.jsp" class="btn btn-outline-secondary py-2">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>