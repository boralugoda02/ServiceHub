<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is ALREADY logged in, send them to the dashboard instead
    // of showing the registration form again.
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <%@include file="header.jsp" %>
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow-lg p-4" style="max-width: 400px; margin: auto;">
            <h3 class="text-center mb-4">Set New Password</h3>
            
            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger"><%= request.getParameter("error") %></div>
            <% } %>

            <form action="reset-password" method="POST">
                <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
                
                <div class="mb-3">
                    <label class="form-label">New Password:</label>
                    <input type="password" name="newPassword" required class="form-control" placeholder="Enter new password">
                </div>
                
                <button type="submit" class="btn btn-primary w-100">Update Password</button>
            </form>
        </div>
    </div>
</body>
</html>