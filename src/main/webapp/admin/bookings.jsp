<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.BookingDAO"%>
<%@page import="com.mycompany.servicehub.dao.UserDAO"%>
<%@page import="com.mycompany.servicehub.dao.ServiceRequestDAO"%>
<%
    BookingDAO bookingDAO = new BookingDAO();
    request.setAttribute("bookingList", bookingDAO.getAllBookings());
    request.setAttribute("userDAO", new UserDAO());
    request.setAttribute("srDAO", new ServiceRequestDAO());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Management - ServiceHub</title>
    <%@include file="../header.jsp" %>
</head>
<body>

    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <h2 class="mb-4 fw-bold">Booking Management</h2>
        
        <c:if test="${not empty param.status}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Booking operation completed successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <div class="card p-4 shadow-sm bg-white">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer</th>
                            <th>Service Request</th>
                            <th>Date & Time</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bk" items="${bookingList}">
                            <tr>
                                <td>#${bk.bookingId}</td>
                                <td>
                                    <c:set var="cust" value="${userDAO.getUserById(bk.customerId)}" />
                                    <c:out value="${not empty cust ? cust.fullName : 'Unknown Customer'}" />
                                </td>
                                <td>
                                    <c:set var="reqObj" value="${srDAO.getRequestById(bk.requestId)}" />
                                    <c:out value="${not empty reqObj ? reqObj.title : 'General Booking'}" />
                                </td>
                                <td>${bk.serviceDate} @ ${bk.serviceTime}</td>
                                <td>
                                    <form action="../BookingServlet" method="POST" class="d-inline">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="${bk.bookingId}">
                                        <select name="status" onchange="this.form.submit()" class="form-select form-select-sm" style="width: auto; display: inline-block;">
                                            <option value="Pending" ${bk.bookingStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="Confirmed" ${bk.bookingStatus == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                            <option value="Accepted" ${bk.bookingStatus == 'Accepted' ? 'selected' : ''}>Accepted</option>
                                            <option value="In Progress" ${bk.bookingStatus == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                            <option value="Completed" ${bk.bookingStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                                            <option value="Cancelled" ${bk.bookingStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                    </form>
                                </td>
                                <td>
                                    <a href="../BookingServlet?action=delete&id=${bk.bookingId}" 
                                       class="btn btn-danger btn-sm fw-semibold" 
                                       onclick="return confirm('Are you sure you want to delete this booking?')">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>