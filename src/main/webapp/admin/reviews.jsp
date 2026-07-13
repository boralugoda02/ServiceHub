<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.ReviewDAO"%>
<%
    ReviewDAO reviewDAO = new ReviewDAO();
    request.setAttribute("reviewList", reviewDAO.getAllReviews());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Reviews - Admin</title>
    <%@include file="../header.jsp" %>
</head>
<body class="bg-light">
    <%@include file="admin-layout.jsp" %>
    <h3 class="mb-4">Review Management</h3>
    
    <input type="text" id="searchInput" class="form-control mb-3" onkeyup="filterReviews()" placeholder="Search by customer name...">
    
    <table class="table table-bordered bg-white shadow-sm" id="reviewTable">
        <thead class="table-dark">
            <tr><th>Customer</th><th>Comment</th><th>Rating</th><th>Status</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <c:forEach var="rev" items="${reviewList}">
                <tr class="${rev.reported ? 'table-warning' : ''}">
                    <td>${rev.customerName}</td>
                    <td>${rev.comment}</td>
                    <td>${rev.rating} / 5</td>
                    <td>${rev.reported ? 'Reported' : 'Normal'}</td>
                    <td>
                        <a href="../ReviewServlet?action=delete&id=${rev.id}" 
                           class="btn btn-danger btn-sm" onclick="return confirm('Delete this review?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div></div>

<script>
function filterReviews() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toUpperCase();
    let table = document.getElementById("reviewTable");
    let tr = table.getElementsByTagName("tr");
    for (let i = 1; i < tr.length; i++) {
        let td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            tr[i].style.display = td.textContent.toUpperCase().indexOf(filter) > -1 ? "" : "none";
        }
    }
}
</script>
</body>
</html>