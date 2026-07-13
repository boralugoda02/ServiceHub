<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2>User Management</h2>
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search users...">
    
    <table class="table table-bordered bg-white">
        <thead>
            <tr><th>Name</th><th>Email</th><th>Role</th><th>Status</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${userList}">
                <tr>
                    <td>${u.username}</td>
                    <td>${u.email}</td>
                    <td>${u.role}</td>
                    <td>${u.status}</td>
                    <td>
                        <a href="UserManagementServlet?action=toggleStatus&id=${u.userId}&status=${u.status == 'Active' ? 'Deactivated' : 'Active'}" 
                           class="btn btn-sm btn-warning">Toggle Status</a>
                        <a href="UserManagementServlet?action=delete&id=${u.userId}" class="btn btn-sm btn-danger">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>