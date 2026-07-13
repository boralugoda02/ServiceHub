<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My Reviews</title>
    <style>
        .review-card { border: 1px solid #ddd; padding: 15px; margin: 10px 0; border-radius: 8px; box-shadow: 2px 2px 5px #eee; }
        .stats { background: #f4f4f4; padding: 20px; border-radius: 8px; }
    </style>
</head>
<body>

    <div class="stats">
        <h3>Rating Overview</h3>
        <p>Average Rating: <strong>${averageRating} / 5.0</strong></p>
        <p>Total Reviews: <strong>${totalReviews}</strong></p>
    </div>

    <div class="reviews-list">
        <h3>Customer Feedback</h3>
        <c:forEach var="rev" items="${reviewList}">
            <div class="review-card">
                <p><strong>Rating:</strong> ${rev.rating} ★</p>
                <p><strong>Comment:</strong> ${rev.comment}</p>
                <small>Date: ${rev.createdAt}</small>
            </div>
        </c:forEach>
    </div>

</body>
</html>