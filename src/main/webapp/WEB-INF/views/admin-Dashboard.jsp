
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bank.pojo.Users"%>

<%
Users admin = (Users) session.getAttribute("loggedUser");
if (admin == null) {
    response.sendRedirect("signIn");
    return;
}
List<Users> usersList = (List<Users>) request.getAttribute("usersList");
%>

<!-- MODAL CODE -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Admin Dashboard | Aashray-UniTrust Bank</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --light:#E7EEFA;
}
body{
    background:linear-gradient(rgba(1,26,65,.7),rgba(1,26,65,.7)),
               url("img/carousel-1.jpg");
    background-size:cover;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}
.header{
    background:var(--brand);
    color:#fff;
    border-radius:18px;
    padding:22px;
    margin-bottom:25px;
    text-align:center;
}
.card-ui{
    background:#fff;
    border-radius:18px;
    padding:20px;
    box-shadow:0 15px 30px rgba(0,0,0,.2);
}
.section-title{
    font-weight:700;
    color:var(--brand);
}
.action-box{
    border:1px solid #ddd;
    border-radius:14px;
    padding:15px;
    transition:.3s;
}
.action-box:hover{
    background:var(--light);
    transform:translateY(-4px);
}
.action-box a{
    text-decoration:none;
    color:#000;
}
.action-link{
    text-decoration:none;
    color:inherit;
    display:block;
}

.action-link:hover{
    color:inherit;
}
.btn-search{
    background:#011A41;
    color:#fff;
    font-weight:600;
    border-radius:10px;
}
.btn-search:hover{
    background:#03316E;
    color:#fff;
}
.btn-search-blue{
    background:#1E88E5;
    color:#fff;
    font-weight:600;
    border-radius:10px;
    border:none;
    transition:0.3s;
}
.btn-search-blue:hover{
    background:#1565C0;
    color:#fff;
}
.btn-search-brand{
    background:#011A41;
    color:#fff;
    font-weight:600;
    border:none;
    border-radius:10px;
}
.btn-search-brand:hover{
    background:#03316E;
    color:#fff;
}

</style>
</head>

<body>

<div class="container py-4">

<!-- HEADER -->
<div class="header">
<i class="fa fa-user-shield fa-3x mb-2"></i>
<h3>Welcome Admin, <%= admin.getFname() %></h3>
<small>Admin Control Panel | Aashray-UniTrust Bank</small>
</div>
<%
String msg = (String) session.getAttribute("msg");
boolean isError = false;

if(msg != null){
    String lowerMsg = msg.toLowerCase();
    if(lowerMsg.contains("not found")
        || lowerMsg.contains("blocked")
        || lowerMsg.contains("invalid")
        || lowerMsg.contains("failed")
        || lowerMsg.contains("error")){
        isError = true;
    }
%>

<div class="modal fade" id="msgModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius:16px; overflow:hidden;">
      
      <!-- HEADER -->
      <div class="modal-header"
           style="background:<%= isError ? "#dc3545" : "#011A41" %>;color:#fff;">
        <h5 class="modal-title">
          <i class="fa <%= isError ? "fa-exclamation-triangle" : "fa-info-circle" %> me-2"></i>
          <%= isError ? "Error" : "Notification" %>
        </h5>
        <button type="button" class="btn-close btn-close-white"
                data-bs-dismiss="modal"></button>
      </div>
      
      <!-- BODY -->
      <div class="modal-body text-center py-4">
        <i class="fa 
           <%= isError ? "fa-times-circle text-danger" : "fa-check-circle" %>
           fa-3x mb-3"></i>

        <p class="fw-semibold mb-0"><%= msg %></p>
      </div>

      <!-- FOOTER -->
      <div class="modal-footer justify-content-center">
        <button type="button"
                class="btn px-4"
                style="background:<%= isError ? "#dc3545" : "#011A41" %>;color:#fff;"
                data-bs-dismiss="modal">
          OK
        </button>
      </div>

    </div>
  </div>
</div>

<%
session.removeAttribute("msg");   // 🔥 repeat popup STOP
}
%>


<div class="card-ui mb-4">
    <form action="admin-user-actions" method="get">
        <div class="row g-2 align-items-center">
            
            <div class="col-md-9">
                <input type="text"
                       name="accountNo"
                       class="form-control"
                       placeholder="Enter Account Number"
                       required>
            </div>

            <div class="col-md-3">
                <button class="btn btn-search-brand w-100">
    <i class="fa fa-search me-1"></i> Search
</button>


            </div>

        </div>
    </form>
</div>


<div class="row g-4">

<!-- ADMIN PROFILE -->
<div class="col-lg-4">
<div class="card-ui">
<h5 class="section-title"><i class="fa fa-id-badge me-2"></i>Admin Profile</h5>
<table class="table table-bordered mt-3">
<tr><th>Email</th><td><%= admin.getEmail() %></td></tr>
<tr><th>Phone</th><td><%= admin.getPhone() %></td></tr>
<tr><th>Role</th><td>ADMIN</td></tr>
</table>

<a href="logout" class="btn btn-dark w-100 mt-3">
<i class="fa fa-sign-out-alt me-2"></i>Logout
</a>
</div>
</div>

<!-- ADMIN ACTIONS -->
<div class="col-lg-8">
<div class="card-ui mb-4">
<h5 class="section-title mb-3"><i class="fa fa-tools me-2"></i>Bank Admin Operations</h5>

<div class="row g-3 text-center">

<div class="col-md-4">
  <a href="add-user" class="action-link">
    <div class="action-box">
      <i class="fa fa-university fa-2x text-success"></i>
      <h6 class="mt-2">Open Account</h6>
    </div>
  </a>
</div>


<div class="col-md-4">
  <a href="showAllAccounts" class="action-link">
    <div class="action-box">
      <i class="fa fa-list fa-2x text-primary"></i>
      <h6 class="mt-2">Accounts</h6>
    </div>
  </a>
</div>


<div class="col-md-4">
  <a href="adminDeposit" class="action-link">
    <div class="action-box">
      <i class="fa fa-plus-circle fa-2x text-success"></i>
      <h6 class="mt-2">Deposit Money</h6>
    </div>
  </a>
</div>

<div class="col-md-4">
  <a href="adminWithdraw" class="action-link">
    <div class="action-box">
      <i class="fa fa-minus-circle fa-2x text-danger"></i>
      <h6 class="mt-2">Withdraw Money</h6>
    </div>
  </a>
</div>

<div class="col-md-4">
  <a href="transactionsadminpanel" class="action-link">
    <div class="action-box">
      <i class="fa fa-exchange-alt fa-2x text-dark"></i>
      <h6 class="mt-2">Transactions</h6>
    </div>
  </a>
</div>

<div class="col-md-4">
  <a href="ActiveAllAccounts" class="action-link">
    <div class="action-box">
      <i class="fa fa-ban fa-2x text-danger"></i>
      <h6 class="mt-2">Blocked Users</h6>
    </div>
  </a>
</div>

<div class="col-md-4">
  <a href="blockAllAccounts" class="action-link">
    <div class="action-box">
      <i class="fa fa-users fa-2x text-success"></i>
      <h6 class="mt-2">Activated Users</h6>
    </div>
  </a>
</div>

<div class="col-md-4">
  <a href="updateUsers" class="action-link">
    <div class="action-box">
      <i class="fa fa-user-edit fa-2x text-warning"></i>
      <h6 class="mt-2">Update Users</h6>
    </div>
  </a>
</div>

<div class="col-md-4">
  <a href="incomingMessages" class="action-link">
    <div class="action-box">
      <i class="fa fa-envelope fa-2x text-primary"></i>
      <h6 class="mt-2">Incoming Messages</h6>
    </div>
  </a>
</div>

</div>
</div>
</div>


<!-- PENDING USERS -->
<div class="card-ui">
<h5 class="section-title mb-3">
<i class="fa fa-hourglass-half me-2"></i>Pending User Approvals
</h5>

<table class="table table-bordered text-center">
<thead>
<tr>
<th>#</th><th>Name</th><th>Email</th><th>Status</th><th>Action</th>
</tr>
</thead>
<tbody>
<%
if(usersList!=null && !usersList.isEmpty()){
int i=1;
for(Users u:usersList){
%>
<tr>
<td><%=i++%></td>
<td><%=u.getFname()%> <%=u.getLname()%></td>
<td><%=u.getEmail()%></td>
<td><span class="badge bg-warning"><%=u.getStatus()%></span></td>
<td>
<a href="viewUser?id=<%=u.getId()%>" class="btn btn-outline-primary btn-sm">
<i class="fa fa-eye me-1"></i>View
</a>

<a href="approveForm?id=<%=u.getId()%>" class="btn btn-success btn-sm ms-1">
<i class="fa fa-check me-1"></i>Approve
</a>
</td>
</tr>
<% }} else { %>
<tr><td colspan="5">No Pending Users</td></tr>
<% } %>
</tbody>
</table>
</div>

</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    var modal = document.getElementById("msgModal");
    if (modal) {
        new bootstrap.Modal(modal).show();
    }
});
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
.. 