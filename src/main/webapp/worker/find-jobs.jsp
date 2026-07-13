<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.dao.ServiceRequestDAO"%>
<%@page import="com.mycompany.servicehub.model.ServiceRequest"%>
<%@page import="java.util.List"%>
<%@include file="../header.jsp" %>
<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <div class="container-fluid">
        <h2 class="mb-4">Available Jobs</h2>

    <form action="find-jobs.jsp" method="GET" class="row g-3 mb-4 p-3 bg-light border rounded">
        <div class="col-md-4">
            <input type="text" name="city" class="form-control" placeholder="Search by City or Location">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
    </form>

    <div class="row">
        <%
            ServiceRequestDAO dao = new ServiceRequestDAO();
            String city = request.getParameter("city");
            List<ServiceRequest> jobs;

            // Load filtered or all pending jobs
            if (city != null && !city.isEmpty()) {
                jobs = dao.getFilteredJobs(city);
            } else {
                jobs = dao.getAllPendingRequests();
            }

            if (jobs.isEmpty()) {
        %>
            <p>No jobs found.</p>
        <% 
            } else {
                for(ServiceRequest job : jobs) {
        %>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title text-primary"><%= job.getTitle() %></h5>
                        <p class="card-text"><%= job.getDescription() %></p>
                        <p><strong>Location:</strong> <%= job.getLocation() %></p>
                        <a href="job-details.jsp?id=<%= job.getRequestId() %>" class="btn btn-outline-info btn-sm">View Details</a>
                        <form action="../JobApplicationServlet" method="POST" class="d-inline">
                            <input type="hidden" name="requestId" value="<%= job.getRequestId() %>">
                            <button type="submit" class="btn btn-success btn-sm">Accept Job</button>
                        </form>
                    </div>
                </div>
            </div>
        <% 
                } 
            }
        %>
    </div>
    </div>
</div>
<%@include file="../footer.jsp" %>