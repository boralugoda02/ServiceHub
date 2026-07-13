<%@page import="com.mycompany.servicehub.dao.NotificationDAO"%>
<%@page import="java.util.List"%>

<div class="card shadow-sm mb-4">
    <div class="card-header bg-dark text-white">
        <h5 class="mb-0">Recent Activities</h5>
    </div>
    <div class="card-body">
        <ul class="list-group list-group-flush">
            <% 
                NotificationDAO nDao = new NotificationDAO();
                List<String> notes = nDao.getRecentNotifications();
                
                if (notes.isEmpty()) {
            %>
                <li class="list-group-item">No new activities.</li>
            <% 
                } else {
                    for (String note : notes) {
            %>
                <li class="list-group-item">
                    <i class="bi bi-bell-fill text-primary me-2"></i> <%= note %>
                </li>
            <% 
                    }
                }
            %>
        </ul>
    </div>
</div>