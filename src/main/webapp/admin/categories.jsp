<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.CategoryDAO"%>
<%
    // Create an instance of CategoryDAO to access the data
    CategoryDAO categoryDAO = new CategoryDAO();
    request.setAttribute("categoryDAO", categoryDAO);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories - Admin</title>
    <%@include file="../header.jsp" %>
</head>
<body>
    <%@include file="admin-layout.jsp" %>
    <h2 class="mb-4">Service Category Management</h2>
    
    <div class="card p-4 shadow-sm mb-4">
        <h5>Add New Category</h5>
        <form action="${pageContext.request.contextPath}/admin/CategoryServlet" method="POST" class="row g-3">
            <input type="hidden" name="action" value="add">
            <div class="col-md-6">
                <input type="text" name="categoryName" placeholder="e.g. Painting, Cleaning" class="form-control" required>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-success w-100">Add</button>
            </div>
        </form>
    </div>

    <div class="card p-4 shadow-sm">
        <h5>Existing Categories</h5>
        <table class="table table-hover mt-3">
            <thead class="table-dark">
                <tr>
                    <th>Category Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cat" items="${categoryDAO.getAllCategories()}">
                    <tr>
                        <td>${cat}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/CategoryServlet?action=delete&categoryName=${cat}" 
                               class="btn btn-danger btn-sm" 
                               onclick="return confirm('Are you sure you want to delete this category?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </div></div>
</body>
</html>