<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.ChatDAO"%>
<%
    ChatDAO chatDAO = new ChatDAO();
    request.setAttribute("chatList", chatDAO.getAllMessages());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Monitoring</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3 class="mb-4">Chat Monitoring</h3>
    
    <input type="text" id="chatSearch" class="form-control mb-3" onkeyup="filterMessages()" placeholder="Search messages...">
    
    <table class="table table-bordered bg-white shadow-sm" id="chatTable">
        <thead class="table-dark">
            <tr><th>Sender</th><th>Message</th><th>Status</th><th>Action</th></tr>
        </thead>
        <tbody>
            <c:forEach var="msg" items="${chatList}">
                <tr class="${msg.reported ? 'table-danger' : ''}">
                    <td>${msg.sender}</td>
                    <td>${msg.message}</td>
                    <td>${msg.reported ? 'Reported' : 'Normal'}</td>
                    <td>
                        <a href="../ChatServlet?action=delete&id=${msg.id}" 
                           class="btn btn-danger btn-sm" onclick="return confirm('Delete this message?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
function filterMessages() {
    let input = document.getElementById("chatSearch").value.toUpperCase();
    let table = document.getElementById("chatTable");
    let tr = table.getElementsByTagName("tr");
    for (let i = 1; i < tr.length; i++) {
        let td = tr[i].getElementsByTagName("td")[1];
        if (td) {
            tr[i].style.display = td.textContent.toUpperCase().indexOf(input) > -1 ? "" : "none";
        }
    }
}
</script>
</body>
</html>