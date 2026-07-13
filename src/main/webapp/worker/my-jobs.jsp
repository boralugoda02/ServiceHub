<%@ page import="com.mycompany.servicehub.model.*, com.mycompany.servicehub.service.*, java.util.*" %>
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
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Jobs - Worker Dashboard</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>Job Management Dashboard</h2>
        
        <table class="table">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Booking job : myJobs) { %>
                <tr>
                    <td><%= job.getBookingId() %></td>
                    <td><%= job.getServiceDate() %></td>
                    <td><%= job.getServiceTime() %></td>
                    <td><strong><%= job.getBookingStatus() %></strong></td>
                    <td>
                        <%-- Dynamic button display based on the booking status --%>
                        <% if (job.getBookingStatus().equals("Pending")) { %>
                            <form action="../BookingServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="action" value="accept">
                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                <button type="submit" class="btn btn-primary">Accept</button>
                            </form>
                            <form action="../BookingServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                <button type="submit" class="btn btn-danger">Reject</button>
                            </form>
                        <% } else if (job.getBookingStatus().equals("Accepted")) { %>
                            <form action="../BookingServlet" method="POST">
                                <input type="hidden" name="action" value="start">
                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                <button type="submit" class="btn btn-warning">Start Job</button>
                            </form>
                        <% } else if (job.getBookingStatus().equals("In Progress")) { %>
                            <form action="../BookingServlet" method="POST">
                                <input type="hidden" name="action" value="complete">
                                <input type="hidden" name="bookingId" value="<%= job.getBookingId() %>">
                                <button type="submit" class="btn btn-success">Complete Job</button>
                            </form>
                        <% } else { %>
                            <span>No actions available</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>