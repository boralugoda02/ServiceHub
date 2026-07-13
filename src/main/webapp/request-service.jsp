<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<div class="container mt-5">
    <h2>Post a New Service Request</h2>
    <form action="../UploadServiceImageServlet" method="POST" enctype="multipart/form-data">
        <div class="mb-3">
            <label>Service Title:</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Description:</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>
        <div class="mb-3">
            <label>Upload Image:</label>
            <input type="file" name="serviceImage" class="form-control" accept="image/png, image/jpeg, image/jpg" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit Request</button>
    </form>
</div>

<%@include file="../footer.jsp" %>