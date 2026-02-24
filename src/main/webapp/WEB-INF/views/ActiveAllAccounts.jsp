<%
String username= (String)session.getAttribute("username");
if(username==null){
    response.sendRedirect("signIn");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bank.pojo.Users"%>
<%@ page import="com.bank.pojo.BankAccount"%>

<%
Users admin = (Users) session.getAttribute("loggedUser");
if (admin == null) {
    response.sendRedirect("signIn");
    return;
}
List<Users> usersList = (List<Users>) request.getAttribute("usersList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Active Accounts | Admin Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root { --brand:#011A41; }

body{
    background:
      linear-gradient(rgba(1,26,65,0.6), rgba(1,26,65,0.6)),
      url("img/carousel-1.jpg");
    background-size:cover;
    background-position:center;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}

/* 🔥 SAME LOGIN ANIMATION */
@keyframes fadeIn{
    from{
        opacity:0;
        transform:translateY(15px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* 🔥 WRAPPER THAT ANIMATES */
.page-wrapper{
    animation: fadeIn 0.6s ease;
}

.header{
    background:var(--brand);
    color:#fff;
    padding:20px;
    border-radius:16px;
    margin-bottom:25px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,.25);
}

.card-ui{
    background:#fff;
    border-radius:16px;
    box-shadow:0 15px 35px rgba(0,0,0,.2);
    padding:20px;
}

.table th{
    background:var(--brand);
    color:#fff;
    text-align:center;
}

.badge-brand{
    background:var(--brand);
}
</style>
</head>

<body>

<div class="container py-4 page-wrapper">

<!-- HEADER -->
<div class="header">
<i class="fa fa-users fa-2x mb-2"></i>
<h4 class="mb-0">Account Activation Panel</h4>
<small>Admin Panel | Aashray-UniTrust Bank</small>
</div>

<!-- CARD -->
<div class="card-ui">

<h5 class="mb-3 fw-bold">
<i class="fa fa-user-check me-2"></i>Customer Accounts Overview
</h5>

<div class="table-responsive">
<table class="table table-bordered align-middle text-center">

<thead>
<tr>
<th>#</th>
<th>Customer Name</th>
<th>Email</th>
<th>Phone</th>
<th>Account No</th>
<th>Account Type</th>
<th>Balance</th>
<th>View Profile</th>
<th>Status / Action</th>
</tr>
</thead>

<tbody>
<%
if(usersList != null && !usersList.isEmpty()){
    int i = 1;
    for(Users u : usersList){
        BankAccount acc = u.getAccount();
%>
<tr>
<td><%= i++ %></td>
<td><strong><%= u.getFname() %> <%= u.getLname() %></strong></td>
<td><%= u.getEmail() %></td>
<td><%= u.getPhone() %></td>

<td>
<span class="badge badge-brand"><%= acc.getAccountNo() %></span>
</td>

<td><%= acc.getAccountType() %></td>
<td>₹ <%= acc.getOpeningBalance() %></td>

<td>
<a href="detailed-account?id=<%= acc.getId() %>"
   class="btn btn-sm btn-outline-primary">
<i class="fa fa-eye"></i> View
</a>
</td>

<td>
<% if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) { %>
<a href="activateAccount?accId=<%= acc.getId() %>"
   class="btn btn-sm btn-outline-success"
   onclick="return confirm('Activate this account?')">
<i class="fa fa-unlock me-1"></i> Activate
</a>
<% } else { %>
<span class="badge bg-success">
<i class="fa fa-check me-1"></i> Active
</span>
<% } %>
</td>

</tr>
<% } } else { %>
<tr>
<td colspan="9">No Accounts Found</td>
</tr>
<% } %>
</tbody>

</table>
</div>
</div>

<!-- MESSAGE MODAL -->
<%
String msg = (String) request.getAttribute("msg");
if(msg != null){
%>
<div class="modal fade" id="msgModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4">

      <div class="modal-header text-white" style="background:#011A41;">
        <h5 class="modal-title">
          <i class="fa fa-info-circle me-2"></i> Notification
        </h5>
        <button class="btn-close btn-close-white"
                data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body text-center py-4">
        <i class="fa fa-check-circle fa-3x text-success mb-3"></i>
        <p class="fw-semibold mb-0"><%= msg %></p>
      </div>

      <div class="modal-footer justify-content-center">
        <button class="btn text-white px-4"
                style="background:#011A41;"
                data-bs-dismiss="modal">
          OK
        </button>
      </div>

    </div>
  </div>
</div>
<%
}
%>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function(){
    let modal = document.getElementById("msgModal");
    if(modal){
        new bootstrap.Modal(modal).show();
    }
});
</script>

</body>
</html>
