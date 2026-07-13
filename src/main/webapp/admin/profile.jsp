<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card p-4 shadow-sm" style="max-width: 500px; margin: auto;">
        <h3>Admin Profile</h3>
        <form action="../AdminServlet" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="action" value="updateProfile">
            <div class="mb-3 text-center">
                <img src="${admin.profileImage}" class="rounded-circle border" width="120" height="120">
                <input type="file" name="image" class="form-control mt-2">
            </div>
            <div class="mb-3">
                <label>Username</label>
                <input type="text" name="username" value="${admin.username}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" value="${admin.email}" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Update Profile</button>
        </form>
        
        <hr class="my-4">
        
        <h5>Change Password</h5>
        <form action="../AdminServlet" method="POST">
            <input type="hidden" name="action" value="changePassword">
            <input type="password" name="newPassword" placeholder="Enter new password" class="form-control mb-2" required>
            <button type="submit" class="btn btn-warning w-100">Update Password</button>
        </form>
    </div>
</div>
</body>
</html>