<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.dao.ServiceRequestDAO"%>
<%@page import="com.mycompany.servicehub.model.ServiceRequest"%>
<%@include file="../header.jsp" %>

<%
    // Get the request ID from the URL parameter
    String requestIdStr = request.getParameter("id");
    if (requestIdStr == null) {
        response.sendRedirect("find-jobs.jsp");
        return;
    }
    
    int requestId = Integer.parseInt(requestIdStr);
    ServiceRequestDAO dao = new ServiceRequestDAO();
    // Assuming you add getRequestById(int id) to your ServiceRequestDAO
    ServiceRequest job = dao.getRequestById(requestId); 
%>

<jsp:include page="../common/sidebar.jsp" />
<div class="main-content">
    <div class="container-fluid">
        <div class="card shadow-lg mt-4">
            <div class="card-header bg-dark text-white">
                <h3 class="mb-0">Job Details</h3>
            </div>
            <div class="card-body p-4">
                <h4 class="fw-bold text-primary"><%= job.getTitle() %></h4>
                <hr>
                <p><strong>Category ID:</strong> <%= job.getCategoryId() %></p>
                <p><strong>Description:</strong> <%= job.getDescription() %></p>
                <p><strong>Area/Location:</strong> <%= job.getLocation() %></p>
                <p><strong>Status:</strong> <span class="badge bg-warning px-3 py-2 rounded-pill fw-semibold text-dark"><%= job.getStatus() %></span></p>
                
                <div class="mt-4">
                    <form action="${pageContext.request.contextPath}/JobApplicationServlet" method="POST" class="d-inline">
                        <input type="hidden" name="requestId" value="<%= job.getRequestId() %>">
                        <button type="submit" class="btn btn-success px-4 fw-semibold me-2">Accept Job</button>
                    </form>
                    
                    <a href="find-jobs.jsp" class="btn btn-secondary px-4">Back to List</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>