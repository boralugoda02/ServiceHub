<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Profile | ServiceHub</title>
    <%@include file="header.jsp" %>
    <title>My Profile</title>
</head>
<body>
    <div class="sidebar p-3">
        <a class="nav-link text-white" href="dashboard.jsp"><i class="fas fa-home me-2"></i> Dashboard</a>
    </div>

    <div class="main-content">
        <h3>Edit Profile</h3>
        <div class="card p-4 mt-4">
            <form action="UpdateProfileServlet" method="POST">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="name" placeholder="John Doe">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" readonly>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init(); // Initialize AOS animations
</script>
</body>
</html>