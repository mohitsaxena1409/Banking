<%
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("signIn");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bank.pojo.ContactMessage"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Incoming Messages | Admin Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{ --brand:#011A41; }

body{
    background:
      linear-gradient(rgba(1,26,65,.6), rgba(1,26,65,.6)),
      url("img/carousel-1.jpg");
    background-size:cover;
    background-position:center;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}

/* ===== Header ===== */
.header{
    background:var(--brand);
    color:#fff;
    padding:20px;
    border-radius:16px;
    margin-bottom:25px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,.25);
}

/* ===== Card ===== */
.card-ui{
    background:#fff;
    border-radius:18px;
    box-shadow:0 15px 35px rgba(0,0,0,.2);
    padding:25px;
}

/* ===== Table ===== */
.table{
    width:100%;
    table-layout:fixed;
}

.table th{
    background:var(--brand);
    color:#fff;
    text-align:center;
    font-size:14px;
}

.table td{
    vertical-align:middle;
    font-size:14px;
}

.msg{
    white-space:normal;
    word-break:break-word;
    text-align:left;
}

/* ===== Status ===== */
.status{
    padding:6px 14px;
    border-radius:20px;
    font-size:12px;
    font-weight:bold;
}

.PENDING{ background:#fff3cd; color:#856404; }
.REPLIED{ background:#d4edda; color:#155724; }

/* ===== Action ===== */
.action-btns{
    white-space:nowrap;
}
.header{
    background:var(--brand);
    color:#fff;
    padding:20px 25px;
    border-radius:16px;
    margin-bottom:25px;
    box-shadow:0 10px 25px rgba(0,0,0,.25);

    display:flex;
    align-items:center;
    justify-content:space-between;
}

</style>
</head>

<body>

<div class="container-fluid py-4">

<div class="header">

    <!-- LEFT -->
    <div>
        <i class="fa fa-envelope fa-2x mb-1"></i>
        <h4 class="mb-0">Incoming Messages</h4>
        <small>Admin Panel | Aashray-UniTrust Bank</small>
    </div>

    <!-- RIGHT -->
    <div>
        <a href="admin-Dashboard"
           class="btn btn-light fw-semibold">
            <i class="fa fa-home me-1"></i> Dashboard
        </a>
    </div>

</div>


<!-- CARD -->
<div class="card-ui">

<h5 class="mb-3 fw-bold">
    <i class="fa fa-inbox me-2"></i>Customer Queries
</h5>

<%
List<ContactMessage> messages =
    (List<ContactMessage>) request.getAttribute("messages");
%>

<div class="table-responsive">

<table class="table table-bordered table-hover align-middle text-center">

<!-- 🔥 COLUMN WIDTH CONTROL -->
<colgroup>
    <col style="width:5%">
    <col style="width:12%">
    <col style="width:15%">
    <col style="width:13%">
    <col style="width:35%">
    <col style="width:10%">
    <col style="width:10%">
</colgroup>

<thead>
<tr>
    <th>#</th>
    <th>Name</th>
    <th>Email</th>
    <th>Subject</th>
    <th>Message</th>
    <th>Status</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<%
if (messages != null && !messages.isEmpty()) {
    int i = 1;
    for (ContactMessage m : messages) {
        String status = m.getStatus() == null ? "PENDING" : m.getStatus();
%>
<tr>
    <td><%= i++ %></td>
    <td><strong><%= m.getName() %></strong></td>
    <td><%= m.getEmail() %></td>
    <td><%= m.getSubject() %></td>

    <td class="msg"><%= m.getMessage() %></td>

    <td>
        <span class="status <%= status %>"><%= status %></span>
    </td>

    <td class="action-btns">
        <a href="replyMessage?id=<%= m.getId() %>"
           class="btn btn-sm btn-outline-success">
            <i class="fa fa-reply"></i>
        </a>

        <a href="deleteMessage?id=<%= m.getId() %>"
           onclick="return confirm('Delete this message?')"
           class="btn btn-sm btn-outline-danger ms-1">
            <i class="fa fa-trash"></i>
        </a>
    </td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="7" class="fw-bold text-muted">
        No Messages Found 🚫
    </td>
</tr>
<%
}
%>
</tbody>

</table>
</div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
