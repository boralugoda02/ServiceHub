<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.RequestDAO"%>
<%
    RequestDAO requestDAO = new RequestDAO();
    request.setAttribute("requestList", requestDAO.getAllRequests());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Service Requests - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Service Requests Management</h3>
    
    <input type="text" id="searchInput" class="form-control mb-3" onkeyup="filterTable()" placeholder="Search by service name...">

    <table class="table table-bordered table-hover" id="requestTable">
        <thead class="table-dark">
            <tr><th>ID</th><th>Service</th><th>Status</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <c:forEach var="req" items="${requestList}">
                <tr>
                    <td>${req.id}</td>
                    <td>${req.service}</td>
                    <td>
                        <form action="../RequestServlet" method="POST">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="id" value="${req.id}">
                            <select name="status" onchange="this.form.submit()">
                                <option value="Pending" ${req.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Accepted" ${req.status == 'Accepted' ? 'selected' : ''}>Accepted</option>
                                <option value="Completed" ${req.status == 'Completed' ? 'selected' : ''}>Completed</option>
                            </select>
                        </form>
                    </td>
                    <td>
                        <a href="../RequestServlet?action=delete&id=${req.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
function filterTable() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toUpperCase();
    let table = document.getElementById("requestTable");
    let tr = table.getElementsByTagName("tr");

    for (let i = 1; i < tr.length; i++) {
        let td = tr[i].getElementsByTagName("td")[1]; // Column 1 is 'Service'
        if (td) {
            let txtValue = td.textContent || td.innerText;
            tr[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
        }
    }
}
</script>
</body>
</html>