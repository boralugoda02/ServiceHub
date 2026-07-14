<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page import="com.mycompany.servicehub.dao.UserDAO"%>
<%
    UserDAO userDAO = new UserDAO();
    request.setAttribute("userList", userDAO.getAllUsers());
%>
<html>
<head>
    <title>User Management - Admin</title>
    <%@include file="../header.jsp" %>
</head>
<body class="bg-light">
    <%@include file="admin-layout.jsp" %>
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
                        <a href="${pageContext.request.contextPath}/admin/UserManagementServlet?action=toggleStatus&id=${u.userId}&status=${u.status == 'Active' ? 'Deactivated' : 'Active'}" 
                           class="btn btn-sm btn-warning">Toggle Status</a>
                        <a href="${pageContext.request.contextPath}/admin/UserManagementServlet?action=delete&id=${u.userId}" class="btn btn-sm btn-danger">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div></div>
</body>
</html>