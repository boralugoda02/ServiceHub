<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is ALREADY logged in, send them straight to the dashboard
    // instead of showing the login form again.
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<%
    // Hide default header error block so we can display it inside the card body
    request.setAttribute("hideErrorInHeader", Boolean.TRUE);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <title>Login | ServiceHub</title>
</head>
<body class="login-body">
    <div class="card login-card shadow-lg" data-aos="zoom-in" data-aos-duration="600">
        <!-- Render error handler here inside the card -->
        <% request.removeAttribute("hideErrorInHeader"); %>
        <jsp:include page="error-handler.jsp" />

        <h3 class="text-center mb-4 fw-bold">Login to ServiceHub</h3>

        <form action="LoginServlet" method="POST">
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" class="form-control" name="email" required placeholder="name@example.com">
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <div class="position-relative">
                    <input type="password" class="form-control pe-5" id="password" name="password" required placeholder="Enter password">
                    <i class="fas fa-eye position-absolute top-50 translate-middle-y end-0 me-3" id="togglePassword" style="cursor: pointer; color: #cbd5e1; z-index: 10;"></i>
                </div>
            </div>
            <div class="d-flex justify-content-between mb-3">
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="remember" id="remember">
                    <label class="form-check-label" for="remember">Remember Me</label>
                </div>
                <a href="forgot-password.jsp" class="text-decoration-none">Forgot Password?</a>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>

        <div class="text-center mt-3">
            <p class="mb-0">Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init(); // Initialize AOS animations

        // Toggle password visibility
        const togglePassword = document.querySelector('#togglePassword');
        const passwordField = document.querySelector('#password');

        togglePassword.addEventListener('click', function () {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
    </script>
</body>
</html>