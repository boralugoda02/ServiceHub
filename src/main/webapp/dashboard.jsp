<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is NOT logged in, send them to the login page
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=LoginRequired");
        return;
    }

    // Redirect to role-specific dashboard
    if ("Admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        return;
    } else if ("Customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/customer/dashboard.jsp");
        return;
    } else if ("Worker".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/worker/dashboard.jsp");
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

    <jsp:include page="common/sidebar.jsp" />

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