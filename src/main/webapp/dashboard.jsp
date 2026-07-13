<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is NOT logged in, send them to the login page
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=LoginRequired");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
    <title>ServiceHub | Dashboard</title>
    <style>
        :root { --primary: #3b82f6; --sidebar-bg: #1e293b; --light-bg: #f8fafc; }
        body { background-color: var(--light-bg); font-family: 'Inter', sans-serif; }
        .sidebar { min-height: 100vh; background: var(--sidebar-bg); color: white; width: 260px; position: fixed; top: 0; left: 0; padding-top: 20px; z-index: 100; }
        .sidebar .nav-link { color: #cbd5e1; padding: 12px 20px; font-weight: 500; border-radius: 8px; margin: 4px 10px; display: flex; align-items: center; transition: all 0.2s ease; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #334155; color: white; }
        .sidebar .nav-link i { width: 24px; font-size: 1.1rem; }
        .main-content { margin-left: 260px; padding: 40px; min-height: 100vh; }
        .stat-card { border: none; border-radius: 16px; background: white; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .status-badge { background-color: #dcfce7; color: #15803d; font-size: 0.85rem; padding: 4px 12px; border-radius: 12px; font-weight: 600; }
        .profile-header-img { width: 70px; height: 70px; border-radius: 50%; border: 3px solid #3b82f6; object-fit: cover; }
        @media (max-width: 768px) { .sidebar { display: none; } .main-content { margin-left: 0; padding: 20px; } }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="px-4 py-3 text-center border-bottom border-secondary mb-3">
            <img src="https://ui-avatars.com/api/?name=<%= user.getFullName() %>&background=3b82f6&color=fff" class="profile-header-img mb-2" alt="Profile">
            <h6 class="mb-0 text-truncate"><%= user.getFullName() %></h6>
            <small class="text-muted"><%= user.getEmail() %></small>
            <div class="mt-2">
                <span class="status-badge"><i class="fas fa-circle text-success me-1"></i><%= user.getAvailabilityStatus() %></span>
            </div>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>

            <%-- Customer specific menus --%>
            <% if("Customer".equals(user.getRole())) { %>
                <a class="nav-link" href="customer/request-service.jsp"><i class="fas fa-plus-circle"></i> Request Service</a>
                <a class="nav-link" href="customer/my-bookings.jsp"><i class="fas fa-calendar-check"></i> My Bookings</a>
            <% } %>

            <%-- Worker specific menus --%>
            <% if("Worker".equals(user.getRole())) { %>
                <a class="nav-link" href="worker/find-jobs.jsp"><i class="fas fa-search"></i> Find Jobs</a>
                <a class="nav-link" href="worker/my-jobs.jsp"><i class="fas fa-briefcase"></i> My Gigs</a>
                <a class="nav-link" href="worker/earnings.jsp"><i class="fas fa-wallet"></i> My Wallet</a>
            <% } %>

            <%-- Admin specific menus --%>
            <% if("Admin".equals(user.getRole())) { %>
                <a class="nav-link" href="admin/manage-users.jsp"><i class="fas fa-users-cog"></i> Manage Users</a>
                <a class="nav-link" href="admin/manage-services.jsp"><i class="fas fa-tools"></i> Manage Services</a>
                <a class="nav-link" href="admin/reports.jsp"><i class="fas fa-chart-bar"></i> Reports</a>
            <% } %>

            <%-- Common menus --%>
            <a class="nav-link" href="customer/notifications.jsp"><i class="fas fa-bell"></i> Notifications</a>
            <a class="nav-link" href="customer/profile.jsp"><i class="fas fa-user"></i> My Profile</a>
            <hr class="mx-3 my-2 text-secondary">
            <a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </nav>
    </div>

    <div class="main-content">
        <h2 class="fw-bold text-dark">Welcome back, <%= user.getFullName() %>!</h2>
        <p class="text-muted">Dashboard View - Role: <%= user.getRole() %></p>

        <div class="row g-4">
            <div class="col-md-12">
                <div class="card p-4">
                    <h5>Overview</h5>
                    <p>Welcome to your unified dashboard. Use the sidebar to navigate to your specific tasks.</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>