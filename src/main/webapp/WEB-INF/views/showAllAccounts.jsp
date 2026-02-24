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

List<Users> usersList =
        (List<Users>) request.getAttribute("usersList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
    
<title>All Bank Accounts | Admin Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
}
body{
    background:#f4f6f9;
    font-family:'Segoe UI',sans-serif;
}
.header{
    background:var(--brand);
    color:#fff;
    padding:20px;
    border-radius:14px;
    margin-bottom:25px;
    text-align:center;
}
.card-ui{
    background:#fff;
    border-radius:14px;
    box-shadow:0 10px 25px rgba(0,0,0,.08);
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
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(15px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.page-wrapper {
    animation: fadeIn 0.6s ease;
}

</style>
</head>

<body>
<body>

<div class="container py-4 page-wrapper">


<!-- HEADER -->
<div class="header">
<i class="fa fa-university fa-2x mb-2"></i>
<h4 class="mb-0">All Bank Accounts</h4>
<small>Admin Panel | Aashray-UniTrust Bank</small>
</div>

<div class="card-ui">

<h5 class="mb-3 text-dark fw-bold">
<i class="fa fa-users me-2"></i>Customer Accounts Overview
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
<th>Account Status</th>
<th>Action</th>
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

<td>
<strong><%= u.getFname() %> <%= u.getLname() %></strong>
</td>

<td><%= u.getEmail() %></td>

<td><%= u.getPhone() %></td>

<td>
<span class="badge badge-brand">
<%= acc.getAccountNo() %>
</span>
</td>

<td><%= acc.getAccountType() %></td>

<td>
₹ <%= acc.getOpeningBalance() %>
</td>

<td>
<% if("ACTIVE".equalsIgnoreCase(acc.getStatus())){ %>
<span class="badge bg-success">ACTIVE</span>
<% } else { %>
<span class="badge bg-danger">BLOCKED</span>
<% } %>
</td>

<td>
<a href="detailed-account?id=<%= acc.getId() %>"
   class="btn btn-sm btn-primary">
<i class="fa fa-eye"></i>
</a>
</td>
</tr>
<%
    }
} else {
%>
<tr>
<td colspan="9">No Accounts Found</td>
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
