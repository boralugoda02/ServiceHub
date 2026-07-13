<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
    
    <%@include file="header.jsp" %>
    <title>Manage Jobs</title>
</head>
    
<body>
    <%@include file="admin-layout.jsp" %>
    <h3>All Posted Jobs</h3>
    <table class="table table-hover mt-3">
        <thead><tr><th>Title</th><th>Provider</th><th>Status</th></tr></thead>
        <tbody>
            <tr><td>Home Painting</td><td>John Doe</td><td><span class="badge bg-success">Completed</span></td></tr>
        </tbody>
    </table>
    </div></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init(); // Initialize AOS animations
</script>
</body>
</html>