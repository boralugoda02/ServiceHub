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
    <title>Edit Profile</title>
    <%@include file="header.jsp" %>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Profile Management</h2>
        
        <% if(request.getParameter("status") != null) { %>
            <div class="alert alert-success">Action successful!</div>
        <% } if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger">Error: <%= request.getParameter("error") %></div>
        <% } %>

        <div class="row">
            <div class="col-md-4">
                <div class="card p-3 text-center">
                    <h5>Profile Photo</h5>
                    <img src="${sessionScope.user.profilePhoto}" width="150" height="150" class="rounded-circle mb-3 mx-auto" alt="Profile Photo">
                    <form action="upload-photo" method="POST" enctype="multipart/form-data">
                        <input type="file" name="profilePhoto" class="form-control mb-2" accept="image/*" required>
                        <button type="submit" class="btn btn-warning w-100">Upload Photo</button>
                    </form>
                </div>
            </div>

            <div class="col-md-8">
                <form action="update-profile" method="POST" class="card p-4 mb-4">
                    <h5>Personal Information</h5>
                    <div class="mb-3">
                        <label>Full Name</label>
                        <input type="text" name="fullName" class="form-control" value="${sessionScope.user.fullName}" required>
                    </div>
                    <div class="mb-3">
                        <label>Phone Number</label>
                        <input type="text" name="phoneNumber" class="form-control" value="${sessionScope.user.phone}" required>
                    </div>
                    <div class="mb-3">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control" value="${sessionScope.user.address}">
                    </div>
                    <div class="mb-3">
                        <label>Skills</label>
                        <input type="text" name="skills" class="form-control" value="${sessionScope.user.skills}">
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>

                <form action="change-password" method="POST" class="card p-4">
                    <h5>Change Password</h5>
                    <div class="mb-3">
                        <label>Old Password</label>
                        <input type="password" name="oldPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>New Password</label>
                        <input type="password" name="newPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-danger">Update Password</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>