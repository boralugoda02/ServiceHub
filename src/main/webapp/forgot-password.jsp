<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is ALREADY logged in, redirect them to the dashboard
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <title>Forgot Password | ServiceHub</title>
</head>
<body class="login-body">
    <div class="card login-card shadow-lg" data-aos="zoom-in" data-aos-duration="600">
        <h3 class="text-center mb-4 fw-bold">Forgot Password</h3>
        
        <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger animated fadeIn mb-3" style="margin-bottom: 20px; padding: 15px; border-radius: 10px; border: 1px solid rgba(239, 68, 68, 0.2); background: rgba(239, 68, 68, 0.1); color: #fca5a5; font-size: 0.9rem;">
                <i class="fas fa-exclamation-circle me-2"></i><strong>Error:</strong> 
                <%= request.getParameter("error").equals("UserNotFound") ? "No account found with that email." : "An unexpected error occurred." %>
            </div>
        <% } %>

        <form action="forgot-password" method="POST">
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" class="form-control" name="email" required placeholder="Enter registered email">
            </div>
            
            <button type="submit" class="btn btn-primary w-100 mt-2">Reset Password</button>
        </form>

        <div class="text-center mt-3">
            <p class="mb-0"><a href="login.jsp">Back to Login</a></p>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>
