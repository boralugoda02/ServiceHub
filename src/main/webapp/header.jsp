<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/error-handler.jsp" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ServiceHub | Professional Service</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; }
    .sidebar { min-height: 100vh; background: #1e293b; color: white; width: 260px; position: fixed; }
    .main-content { margin-left: 260px; padding: 25px; }
    @media (max-width: 768px) {
        .sidebar { display: none; }
        .main-content { margin-left: 0; }
    }
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">