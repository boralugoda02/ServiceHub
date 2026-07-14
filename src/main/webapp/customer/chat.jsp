<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Chat with Worker</title>
    <style>
        /* Chat box styling */
        #chat-container { height: 400px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px; background: #f9f9f9; }
        .msg { margin: 10px; padding: 10px; border-radius: 10px; max-width: 70%; }
        .sender { background: #dcf8c6; margin-left: auto; } /* Sent by user */
        .receiver { background: #fff; margin-right: auto; } /* Received */
    </style>
</head>
<body>

<h3>Chat History</h3>
<div id="chat-container">
    <c:forEach var="msg" items="${messages}">
        <div class="msg ${msg.senderId == sessionScope.userId ? 'sender' : 'receiver'}">
            <p>${msg.message}</p>
            <small style="color: gray;">${msg.sentAt}</small>
        </div>
    </c:forEach>
</div>

<form action="${pageContext.request.contextPath}/ChatServlet" method="POST">
    <input type="hidden" name="action" value="SEND">
    <input type="hidden" name="bookingId" value="${bookingId}">
    <input type="hidden" name="receiverId" value="${receiverId}">
    <input type="text" name="message" required placeholder="Type your message here...">
    <button type="submit">Send</button>
</form>

<script>
    // Auto scroll to bottom
    var container = document.getElementById("chat-container");
    container.scrollTop = container.scrollHeight;
</script>

</body>
</html>