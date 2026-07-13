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
    <%@include file="header.jsp" %>
    <title>Dashboard</title>
</head>
<body>

    <div class="sidebar p-3">
        <div class="text-center mb-4">
            <div class="profile-img mx-auto mb-2"></div>
            <h6>Welcome, ${sessionScope.user.fullName}</h6>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link text-white" href="dashboard.jsp"><i class="fas fa-home me-2"></i> Dashboard</a>
            <a class="nav-link text-white" href="#"><i class="fas fa-briefcase me-2"></i> My Jobs</a>
            <a class="nav-link text-white" href="#"><i class="fas fa-bell me-2"></i> Notifications</a>
            <a class="nav-link text-white" href="#"><i class="fas fa-user-edit me-2"></i> Edit Profile</a>
            <hr class="text-secondary">
            <a class="nav-link text-white" href="#"><i class="fas fa-cog me-2"></i> Settings</a>
            <a class="nav-link text-white" href="#"><i class="fas fa-question-circle me-2"></i> Help</a>
            <a class="nav-link text-danger mt-3" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a>
        </nav>
    </div>

    <div class="main-content">
        <h3>Dashboard Overview</h3>
        
        <div class="row mt-4">
            <div class="col-md-3">
                <div class="card p-3">
                    <p>Jobs Done</p><h4>12</h4>
                    <div class="progress" style="height: 5px;"><div class="progress-bar bg-success" style="width: 75%"></div></div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <p>Active</p><h4>3</h4>
                    <div class="progress" style="height: 5px;"><div class="progress-bar bg-primary" style="width: 40%"></div></div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <p>Pending</p><h4>2</h4>
                    <div class="progress" style="height: 5px;"><div class="progress-bar bg-warning" style="width: 25%"></div></div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <p>Rating</p><h4>4.8 / 5.0</h4>
                    <div class="progress" style="height: 5px;"><div class="progress-bar bg-info" style="width: 90%"></div></div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-8">
                <div class="card p-4">
                    <h5>Recent Jobs</h5>
                    <table class="table mt-3">
                        <thead><tr><th>Job</th><th>Status</th></tr></thead>
                        <tbody><tr><td>House Painting</td><td><span class="badge bg-success">Done</span></td></tr></tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4">
                    <h5>Quick Actions</h5>
                    <div class="d-grid gap-2 mt-3">
                        <a href="request-service.jsp" class="btn btn-primary">Post New Job</a>
                        <a href="#" class="btn btn-outline-secondary">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>