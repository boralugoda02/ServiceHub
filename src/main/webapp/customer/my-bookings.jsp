<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.servicehub.model.Booking, com.mycompany.servicehub.model.User, com.mycompany.servicehub.service.BookingService, com.mycompany.servicehub.dao.UserDAO, java.util.List"%>
<%
    Integer customerId = (Integer) session.getAttribute("customerId");
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "Customer";
    if (customerId == null) { response.sendRedirect("../login.jsp"); return; }
    BookingService bookingService = new BookingService();
    List<Booking> bookings = bookingService.getCustomerBookings(customerId);
    UserDAO userDAO = new UserDAO();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings - ServiceHub</title>
    <%@include file="../header.jsp" %>
    <style>
        .table-card { background: white; border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.04); overflow: hidden; }
        .status-pending { background-color: #fef3c7; color: #d97706; }
        .status-confirmed { background-color: #dbeafe; color: #2563eb; }
        .status-accepted { background-color: #e0e7ff; color: #4f46e5; }
        .status-inprogress { background-color: #f3e8ff; color: #9333ea; }
        .status-completed { background-color: #d1fae5; color: #059669; }
        .status-cancelled { background-color: #fee2e2; color: #dc2626; }
    </style>
</head>
<body>
    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-dark mb-0">My Bookings</h2>
                <a href="request-service.jsp" class="btn btn-primary fw-semibold"><i class="fa-solid fa-plus me-2"></i>New Booking</a>
            </div>
            
            <% if (request.getParameter("status") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    Operation completed successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card table-card">
                <div class="table-responsive">
                    <table class="table table-hover mb-0 align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Booking ID</th>
                                <th>Job Title</th>
                                <th>Worker</th>
                                <th>Date & Time</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (bookings != null && !bookings.isEmpty()) { 
                                for (Booking b : bookings) { 
                                    String statusClass = "status-pending";
                                    String status = b.getBookingStatus();
                                    if ("Confirmed".equalsIgnoreCase(status)) statusClass = "status-confirmed";
                                    else if ("Accepted".equalsIgnoreCase(status)) statusClass = "status-accepted";
                                    else if ("In Progress".equalsIgnoreCase(status)) statusClass = "status-inprogress";
                                    else if ("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
                                    else if ("Cancelled".equalsIgnoreCase(status) || "Rejected".equalsIgnoreCase(status)) statusClass = "status-cancelled";
                                    
                                    User worker = null;
                                    if (b.getWorkerId() != null && b.getWorkerId() > 0) {
                                        worker = userDAO.getUserById(b.getWorkerId());
                                    }
                            %>
                                <tr>
                                    <td>#<%= b.getBookingId() %></td>
                                    <td><strong><%= b.getRequestTitle() %></strong></td>
                                    <td>
                                        <% if (worker != null) { %>
                                            <%= worker.getFullName() %>
                                        <% } else { %>
                                            <span class="text-muted"><i class="fas fa-spinner fa-spin me-1"></i>Finding Worker...</span>
                                        <% } %>
                                    </td>
                                    <td><%= b.getServiceDate() %> @ <%= b.getServiceTime() %></td>
                                    <td><span class="badge <%= statusClass %> px-3 py-2 rounded-pill fw-semibold"><%= status %></span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/customer/booking-details.jsp?id=<%= b.getBookingId() %>" class="btn btn-outline-info btn-sm fw-semibold me-1">
                                            <i class="fas fa-info-circle me-1"></i>Details
                                        </a>
                                        
                                        <% if (worker != null) { %>
                                            <a href="${pageContext.request.contextPath}/ChatServlet?action=LOAD&bookingId=<%= b.getBookingId() %>&receiverId=<%= b.getWorkerId() %>" class="btn btn-outline-primary btn-sm fw-semibold me-1">
                                                <i class="fas fa-comments me-1"></i>Chat
                                            </a>
                                            <% if ("Completed".equalsIgnoreCase(status)) { %>
                                                <a href="${pageContext.request.contextPath}/reviews.jsp?bookingId=<%= b.getBookingId() %>&workerId=<%= b.getWorkerId() %>" class="btn btn-warning btn-sm fw-semibold text-white me-1">
                                                    <i class="fas fa-star me-1"></i>Review
                                                </a>
                                            <% } %>
                                        <% } %>

                                        <% if ("Pending".equalsIgnoreCase(status) || "Confirmed".equalsIgnoreCase(status)) { %>
                                            <form action="${pageContext.request.contextPath}/BookingServlet" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                                                <button type="submit" class="btn btn-outline-danger btn-sm fw-semibold">
                                                    <i class="fas fa-times me-1"></i>Cancel
                                                </button>
                                            </form>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } } else { %>
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">No bookings found.</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>