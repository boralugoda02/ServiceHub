<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // Ensure the user is logged in
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
    <title>ServiceHub | Profile Management</title>
</head>
<body>

    <!-- Sidebar -->
    <jsp:include page="common/sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <h2 class="mb-4 fw-bold">Profile Management</h2>
        
        <% if(request.getParameter("status") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Action successful!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Error: <%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card p-4 text-center shadow-sm">
                    <h5 class="fw-bold mb-3">Profile Photo</h5>
                    <img src="${not empty sessionScope.user.profilePhoto ? sessionScope.user.profilePhoto : ''}" 
                         onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=3b82f6&color=fff'" 
                         width="150" height="150" class="rounded-circle mb-3 mx-auto shadow" alt="Profile Photo" style="object-fit: cover;">
                    <form action="upload-photo" method="POST" enctype="multipart/form-data">
                        <input type="file" name="profilePhoto" class="form-control mb-2" accept="image/*" required>
                        <button type="submit" class="btn btn-warning w-100 fw-semibold">Upload Photo</button>
                    </form>
                </div>
            </div>

            <div class="col-md-8">
                <form action="update-profile" method="POST" class="card p-4 mb-4 shadow-sm">
                    <h5 class="fw-bold mb-3">Personal Information</h5>
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" value="${sessionScope.user.fullName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="text" name="phoneNumber" class="form-control" value="${sessionScope.user.phone}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <input type="text" name="address" class="form-control" value="${sessionScope.user.address}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Skills</label>
                        <input type="text" name="skills" class="form-control" value="${sessionScope.user.skills}">
                    </div>
                    <button type="submit" class="btn btn-primary fw-semibold">Save Changes</button>
                </form>

                <form action="change-password" method="POST" class="card p-4 shadow-sm">
                    <h5 class="fw-bold mb-3">Change Password</h5>
                    <div class="mb-3">
                        <label class="form-label">Old Password</label>
                        <input type="password" name="oldPassword" class="form-control" required placeholder="Enter old password">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">New Password</label>
                        <input type="password" name="newPassword" class="form-control" required placeholder="Enter new password">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required placeholder="Confirm new password">
                    </div>
                    <button type="submit" class="btn btn-danger fw-semibold">Update Password</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>