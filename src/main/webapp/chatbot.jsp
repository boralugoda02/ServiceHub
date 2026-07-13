<html>
<head>
    <style>
        /* Chatbot floating container */
        #chatbot-wrapper {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            overflow: hidden;
            display: none; /* Initially hidden */
            z-index: 1000;
        }
        #chat-header { padding: 15px; background: #007bff; color: #fff; font-weight: bold; cursor: pointer; }
        #bot-response { padding: 15px; height: 200px; overflow-y: auto; background: #f9f9f9; border-bottom: 1px solid #eee; }
        .input-area { padding: 10px; display: flex; }
        #user-query { flex: 1; padding: 5px; border: 1px solid #ccc; border-radius: 4px; }

        /* Floating Trigger Button */
        #chat-trigger {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 15px 20px;
            background: #007bff;
            color: #fff;
            border-radius: 50px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
<div id="chat-trigger" onclick="toggleChat()">Chat with Support</div>
<div id="chatbot-wrapper">
    <div id="chat-header" onclick="toggleChat()">Support Bot (Close)</div>
    <div id="bot-response">Hi! How can I help you today?</div>
    <div class="input-area">
        <input type="text" id="user-query" placeholder="Ask me anything...">
        <button onclick="askBot()">Send</button>
    </div>
</div>
<script>
    function toggleChat() {
        var chat = document.getElementById("chatbot-wrapper");
        var trigger = document.getElementById("chat-trigger");
        if (chat.style.display === "none" || chat.style.display === "") {
            chat.style.display = "block";
            trigger.style.display = "none";
        } else {
            chat.style.display = "none";
            trigger.style.display = "block";
        }
    }
    function askBot() {
        let query = document.getElementById("user-query").value;
        let responseDiv = document.getElementById("bot-response");

        if(query.trim() === "") return;
        fetch('ChatbotServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'query=' + encodeURIComponent(query)
        })
        .then(response => response.text())
        .then(data => {
            responseDiv.innerHTML += "<p><b>You:</b> " + query + "</p>";
            responseDiv.innerHTML += "<p><b>Bot:</b> " + data + "</p>";
            document.getElementById("user-query").value = ""; // Clear input
            responseDiv.scrollTop = responseDiv.scrollHeight; // Auto scroll
        });
    }
</script>
</body>
</html>