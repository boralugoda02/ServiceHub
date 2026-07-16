<%-- This component handles all error messages from the URL --%>
<%@page pageEncoding="UTF-8"%>
<%
	    String headerErrorMsgValue = request.getParameter("error");
	    if (headerErrorMsgValue != null && !Boolean.TRUE.equals(request.getAttribute("hideErrorInHeader"))) {
	%>

    <div class="alert alert-danger animated fadeIn" style="margin-bottom: 20px; padding: 15px; border-radius: 10px; border: 1px solid rgba(239, 68, 68, 0.2); background: rgba(239, 68, 68, 0.1); color: #ef4444; font-size: 0.9rem;">
        <i class="fas fa-exclamation-circle me-2"></i><strong>Error: </strong>
        <%
            switch (headerErrorMsgValue) {
                case "DuplicateEmail": out.print("This email is already registered!"); break;
                case "InvalidPassword": out.print("Incorrect password. Please try again."); break;
                case "InvalidLogin": out.print("Invalid email or password."); break;
                case "EmptyFields": out.print("All fields are required."); break;
                case "InvalidImageType": out.print("Invalid file format! Please upload JPG or PNG."); break;
                case "NoFileSelected": out.print("Please choose a photo before uploading."); break;
                case "UnauthorizedAccess": out.print("Please log in to access that page."); break;
                case "LoginRequired": out.print("Please log in to continue."); break;
                case "SessionExpired": out.print("Your session has expired. Please log in again."); break;
                case "DatabaseError": out.print("A database error occurred. Please try again."); break;
                default: out.print(headerErrorMsgValue); // Fallback to raw error value if not mapped
            }
        %>
    </div>
<% } %>