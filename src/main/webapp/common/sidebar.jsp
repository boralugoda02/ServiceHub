<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    User sidebarUser = (User) session.getAttribute("user");
    if (sidebarUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=LoginRequired");
        return;
    }
    String currentURI = request.getRequestURI();
%>
<div class="sidebar">
    <div class="px-4 py-3 text-center border-bottom border-secondary mb-3">
        <img src="https://ui-avatars.com/api/?name=<%= sidebarUser.getFullName() %>&background=3b82f6&color=fff" class="profile-header-img mb-2" alt="Profile">
        <h6 class="mb-0 text-white text-truncate"><%= sidebarUser.getFullName() %></h6>
        <small class="text-muted"><%= sidebarUser.getEmail() %></small>
        <div class="mt-2">
            <span class="status-badge"><i class="fas fa-circle text-success me-1"></i><%= sidebarUser.getAvailabilityStatus() %></span>
        </div>
    </div>
    <nav class="nav flex-column">
        <%-- Main Dashboard link --%>
        <% if ("Admin".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("admin/dashboard") || currentURI.contains("DashboardServlet") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/DashboardServlet"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <% } else if ("Customer".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("customer/dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/customer/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <% } else if ("Worker".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("worker/dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/worker/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <% } %>

        <%-- Customer specific menus --%>
        <% if("Customer".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("request-service") ? "active" : "" %>" href="${pageContext.request.contextPath}/customer/request-service.jsp"><i class="fas fa-plus-circle"></i> Request Service</a>
            <a class="nav-link <%= currentURI.contains("my-bookings") ? "active" : "" %>" href="${pageContext.request.contextPath}/customer/my-bookings.jsp"><i class="fas fa-calendar-check"></i> My Bookings</a>
        <% } %>

        <%-- Worker specific menus --%>
        <% if("Worker".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("find-jobs") ? "active" : "" %>" href="${pageContext.request.contextPath}/worker/find-jobs.jsp"><i class="fas fa-search"></i> Find Jobs</a>
            <a class="nav-link <%= currentURI.contains("my-jobs") ? "active" : "" %>" href="${pageContext.request.contextPath}/worker/my-jobs.jsp"><i class="fas fa-briefcase"></i> My Gigs</a>
            <a class="nav-link <%= currentURI.contains("earnings") ? "active" : "" %>" href="${pageContext.request.contextPath}/worker/earnings.jsp"><i class="fas fa-wallet"></i> My Wallet</a>
        <% } %>

        <%-- Admin specific menus --%>
        <% if("Admin".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("users.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/users.jsp"><i class="fas fa-users-cog"></i> Manage Users</a>
            <a class="nav-link <%= currentURI.contains("categories.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/categories.jsp"><i class="fas fa-tools"></i> Manage Services</a>
            <a class="nav-link <%= currentURI.contains("reports.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/reports.jsp"><i class="fas fa-chart-bar"></i> Reports</a>
            <a class="nav-link <%= currentURI.contains("bookings.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/bookings.jsp"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
        <% } %>

        <%-- Common menus --%>
        <% if ("Admin".equals(sidebarUser.getRole())) { %>
            <a class="nav-link <%= currentURI.contains("notifications") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/notifications.jsp"><i class="fas fa-bell"></i> System Notifications</a>
        <% } else { %>
            <a class="nav-link <%= currentURI.contains("notifications") ? "active" : "" %>" href="${pageContext.request.contextPath}/customer/notifications.jsp"><i class="fas fa-bell"></i> Notifications</a>
        <% } %>
        <a class="nav-link <%= currentURI.contains("profile.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/profile.jsp"><i class="fas fa-user"></i> My Profile</a>
        <hr class="mx-3 my-2 text-secondary">
        <a class="nav-link text-danger" href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>
</div>
