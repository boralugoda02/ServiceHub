<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.servicehub.model.User, com.mycompany.servicehub.dao.ReviewDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp?error=LoginRequired");
        return;
    }
    ReviewDAO rDao = new ReviewDAO();
    request.setAttribute("reviews", rDao.getReviewsByUser(loggedUser.getUserId()));
%>
<!DOCTYPE html>
<html>
<head>
    <title>Rate Your Experience - ServiceHub</title>
    <%@include file="header.jsp" %>
    <style>
        .rating { direction: rtl; display: inline-block; }
        .rating input { display: none; }
        .rating label { color: #cbd5e1; font-size: 36px; cursor: pointer; transition: color 0.2s ease; }
        .rating input:checked ~ label, .rating label:hover, .rating label:hover ~ label { color: #fbbf24; }
        .review-textarea { min-height: 120px; border-radius: 8px; border: 1px solid #cbd5e1; padding: 12px; font-size: 0.95rem; }
        .review-textarea:focus { border-color: #3b82f6; outline: none; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); }
    </style>
</head>
<body class="bg-light">

    <div class="container py-5" style="max-width: 650px;">
        <div class="card p-4 shadow-sm bg-white mb-4">
            <h3 class="fw-bold text-dark mb-1">Leave a Review</h3>
            <p class="text-muted small mb-4">Share your experience with other users on ServiceHub.</p>
            
            <form action="ReviewServlet" method="POST">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="bookingId" value="${param.bookingId}">
                <input type="hidden" name="reviewedUserId" value="${param.workerId}">
                <input type="hidden" name="reviewerId" value="<%= loggedUser.getUserId() %>">

                <div class="mb-3">
                    <label class="form-label fw-semibold text-muted small d-block mb-1">Rating</label>
                    <div class="rating">
                        <input type="radio" name="rating" id="star5" value="5" required><label for="star5">★</label>
                        <input type="radio" name="rating" id="star4" value="4"><label for="star4">★</label>
                        <input type="radio" name="rating" id="star3" value="3"><label for="star3">★</label>
                        <input type="radio" name="rating" id="star2" value="2"><label for="star2">★</label>
                        <input type="radio" name="rating" id="star1" value="1"><label for="star1">★</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold text-muted small">Your Comment</label>
                    <textarea name="comment" class="form-control review-textarea" placeholder="Write your review here..." required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 fw-semibold">Submit Review</button>
            </form>
        </div>

        <div class="card p-4 shadow-sm bg-white">
            <h4 class="fw-bold text-dark mb-3">Your Previous Reviews</h4>
            <div class="list-group list-group-flush">
                <c:choose>
                    <c:when var="hasReviews" test="${empty reviews}">
                        <p class="text-muted mb-0 small">You haven't submitted any reviews yet.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rev" items="${reviews}">
                            <div class="list-group-item px-0 py-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="text-warning fw-semibold">
                                        <c:forEach begin="1" end="${rev.rating}">★</c:forEach>
                                        <c:forEach begin="${rev.rating + 1}" end="5">☆</c:forEach>
                                    </span>
                                </div>
                                <p class="text-dark mb-1 small">${rev.comment}</p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>