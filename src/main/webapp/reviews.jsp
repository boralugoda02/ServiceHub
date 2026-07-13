<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Rate Your Experience</title>
    <style>
        .rating { direction: rtl; display: inline-block; }
        .rating input { display: none; }
        .rating label { color: #ddd; font-size: 30px; cursor: pointer; }
        .rating input:checked ~ label, .rating label:hover, .rating label:hover ~ label { color: #f5c518; }
    </style>
</head>
<body>

<h3>Leave a Review</h3>
<form action="ReviewServlet" method="POST">
    <input type="hidden" name="action" value="SAVE">
    <input type="hidden" name="bookingId" value="${param.bookingId}">
    <input type="hidden" name="reviewedUserId" value="${param.workerId}">

    <div class="rating">
        <input type="radio" name="rating" id="star5" value="5"><label for="star5">★</label>
        <input type="radio" name="rating" id="star4" value="4"><label for="star4">★</label>
        <input type="radio" name="rating" id="star3" value="3"><label for="star3">★</label>
        <input type="radio" name="rating" id="star2" value="2"><label for="star2">★</label>
        <input type="radio" name="rating" id="star1" value="1"><label for="star1">★</label>
    </div>

    <br>
    <textarea name="comment" placeholder="Write your review here..." required></textarea>
    <br>
    <button type="submit">Submit Review</button>
</form>

<hr>

<h3>Previous Reviews</h3>
<ul>
    <c:forEach var="rev" items="${reviews}">
        <li>
            <strong>Rating: ${rev.rating} ★</strong><br>
            <p>${rev.comment}</p>
            <small>Reviewed on: ${rev.createdAt}</small>
        </li>
    </c:forEach>
</ul>

</body>
</html>