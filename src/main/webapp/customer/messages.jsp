<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
     <title>Messages</title>
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="chat-container">
            <div class="conv-list">
                <div class="p-3 border-bottom bg-primary text-white"><h5>Chats</h5></div>
                <div class="list-group list-group-flush">
                    <a href="#" class="list-group-item list-group-item-action p-3">John Doe <br><small class="text-muted">See you at 10am</small></a>
                </div>
            </div>

            <div class="chat-box">
                <div class="p-3 border-bottom"><strong>John Doe</strong></div>
                <div class="messages-area">
                    <div class="msg msg-received">Hi, are you coming for the plumbing?</div>
                    <div class="msg msg-sent">Yes, I am on my way!</div>
                </div>
                
                <div class="p-3 border-top d-flex gap-2">
                    <button class="btn btn-light"><i class="fas fa-paperclip"></i></button>
                    <button class="btn btn-light"><i class="fas fa-map-marker-alt"></i></button>
                    <input type="text" class="form-control" placeholder="Type a message...">
                    <button class="btn btn-primary"><i class="fas fa-paper-plane"></i></button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init(); // Initialize AOS animations
</script>
</body>
</html>