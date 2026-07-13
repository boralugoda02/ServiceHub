<%-- This component handles all error messages from the URL --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
    Boolean hideErrorInHeader = (Boolean) request.getAttribute("hideErrorInHeader");
    if (error != null && !Boolean.TRUE.equals(hideErrorInHeader)) {
%>
    <div class="alert alert-danger animated fadeIn" style="margin-bottom: 20px; padding: 15px; border-radius: 10px; border: 1px solid rgba(239, 68, 68, 0.2); background: rgba(239, 68, 68, 0.1); color: #fca5a5; font-size: 0.9rem;">
        <i class="fas fa-exclamation-circle me-2"></i><strong>Error:</strong>
        <%
            switch (error) {
                case "DuplicateEmail": out.print("This email is already registered!"); break;
                case "InvalidPassword": out.print("Incorrect password. Please try again."); break;
                case "InvalidLogin": out.print("Invalid email or password."); break;
                case "EmptyFields": out.print("All fields are required."); break;
                case "InvalidImageType": out.print("Invalid file format! Please upload JPG or PNG."); break;
                case "UnauthorizedAccess": out.print("Please log in to access that page."); break;
                case "LoginRequired": out.print("Please log in to continue."); break;
                case "SessionExpired": out.print("Your session has expired. Please log in again."); break;
                default: out.print("An unexpected error occurred.");
            }
        %>
    </div>
<% } %>