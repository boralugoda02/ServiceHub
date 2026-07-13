<%@ page import="com.mycompany.servicehub.model.*, com.mycompany.servicehub.service.*, com.mycompany.servicehub.dao.UserDAO, java.util.*" %>
<%
    // Ensure the worker is logged in
    com.mycompany.servicehub.model.User user = (com.mycompany.servicehub.model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    Integer workerId = user.getUserId();

    BookingService bookingService = new BookingService();
    // Retrieve jobs assigned to this worker
    List<Booking> myJobs = bookingService.getJobsByWorker(workerId);
    UserDAO userDAO = new UserDAO();
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Jobs - Worker Dashboard</title>
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
            <h2 class="fw-bold text-dark mb-4">My Gigs Dashboard</h2>
            
            <% if (request.getParameter("status") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    Job status updated successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card table-card p-3">
                <div class="table-responsive">
                    <table class="table table-hover mb-0 align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Booking ID</th>
                                <th>Job Title</th>
                                <th>Customer Name</th>
                                <th>Date & Time</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (myJobs != null && !myJobs.isEmpty()) { 
                                for (Booking job : myJobs) { 
                                    String statusClass = "status-pending";
                                    String status = job.getBookingStatus();
                                    if ("Confirmed".equalsIgnoreCase(status)) statusClass = "status-confirmed";
                                    else if ("Accepted".equalsIgnoreCase(status)) statusClass = "status-accepted";
                                    else if ("In Progress".equalsIgnoreCase(status)) statusClass = "status-inprogress";
                                    else if ("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
                                    else if ("Cancelled".equalsIgnoreCase(status) || "Rejected".equalsIgnoreCase(status)) statusClass = "status-cancelled";

                                    User customer = userDAO.getUserById(job.getCustomerId());
                            %>
                            <tr>
                                <td>#<%= job.getBookingId() %></td>
                                <td><strong><%= job.getRequestTitle() %></strong></td>
                                <td><%= customer != null ? customer.getFullName() : "Unknown" %></td>
                                <td><%= job.getServiceDate() %> @ <%= job.getServiceTime() %></td>
                                <td><span class="badge <%= statusClass %> px-3 py-2 rounded-pill fw-semibold"><%= status %></span></td>
                                <td>
                                    <div class="d-flex align-items-center flex-wrap gap-2">
                                        <a href="${pageContext.request.contextPath}/worker/job-details.jsp?id=<%= job.getRequestId() %>" class="btn btn-outline-info btn-sm fw-semibold">
                                            <i class="fas fa-info-circle me-1"></i>Details
                                        </a>

                                        <a href="${pageContext.request.contextPath}/ChatServlet?action=LOAD&bookingId=<%= job.getBookingId() %>&receiverId=<%= job.getCustomerId() %>" class="btn btn-outline-primary btn-sm fw-semibold">
                                            <i class="fas fa-comments me-1"></i>Chat
                                        </a>

                                        <%-- Dynamic button display based on the booking status --%>
                                        <% if ("Pending".equalsIgnoreCase(status)) { %>
                                            <form action="${pageContext.request.contextPath}/BookingServlet" method="POST" class="d-inline mb-0">
                                                <input type="hidden" name="action" value="accept">
                                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                                <button type="submit" class="btn btn-success btn-sm fw-semibold">Accept</button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/BookingServlet" method="POST" class="d-inline mb-0">
                                                <input type="hidden" name="action" value="reject">
                                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm fw-semibold">Reject</button>
                                            </form>
                                        <% } else if ("Accepted".equalsIgnoreCase(status)) { %>
                                            <form action="${pageContext.request.contextPath}/BookingServlet" method="POST" class="d-inline mb-0">
                                                <input type="hidden" name="action" value="start">
                                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                                <button type="submit" class="btn btn-warning btn-sm fw-semibold text-white">Start Job</button>
                                            </form>
                                        <% } else if ("In Progress".equalsIgnoreCase(status)) { %>
                                            <form action="${pageContext.request.contextPath}/BookingServlet" method="POST" class="d-inline mb-0">
                                                <input type="hidden" name="action" value="complete">
                                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                                <button type="submit" class="btn btn-success btn-sm fw-semibold">Complete Job</button>
                                            </form>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                            <% } } else { %>
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">No jobs assigned yet.</td>
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