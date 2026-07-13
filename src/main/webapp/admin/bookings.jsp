<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.BookingDAO"%>
<%
    BookingDAO bookingDAO = new BookingDAO();
    request.setAttribute("bookingList", bookingDAO.getAllBookings());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3 class="mb-4">Booking Management</h3>
    <table class="table table-bordered bg-white shadow-sm">
        <thead class="table-dark">
            <tr><th>ID</th><th>Customer</th><th>Service</th><th>Status</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <c:forEach var="bk" items="${bookingList}">
                <tr>
                    <td>${bk.id}</td>
                    <td>${bk.customerName}</td>
                    <td>${bk.serviceName}</td>
                    <td>
                        <form action="../BookingServlet" method="POST" class="d-inline">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${bk.id}">
                            <select name="status" onchange="this.form.submit()" class="form-select form-select-sm">
                                <option value="Pending" ${bk.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Confirmed" ${bk.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                <option value="Cancelled" ${bk.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </form>
                    </td>
                    <td>
                        <a href="../BookingServlet?action=delete&id=${bk.id}" 
                           class="btn btn-danger btn-sm" onclick="return confirm('Delete this booking?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>