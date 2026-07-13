<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is ALREADY logged in, send them to the dashboard instead
    // of showing the registration form again.
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Error Occurred</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light text-center mt-5">
    <div class="container">
        <h1 class="display-4">Oops!</h1>
        <p class="lead">Something went wrong. Our team is looking into it.</p>
        <a href="index.jsp" class="btn btn-primary">Go Home</a>
    </div>
</body>
</html>