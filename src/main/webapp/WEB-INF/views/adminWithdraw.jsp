<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.bank.pojo.Users,com.bank.pojo.BankAccount" %>

<%
Users admin = (Users) session.getAttribute("loggedUser");
if (admin == null || !"ADMIN".equals(admin.getRole())) {
    response.sendRedirect("signIn");
    return;
}

Users user = (Users) request.getAttribute("user");
BankAccount account = (BankAccount) request.getAttribute("account");

String msg = (String) request.getAttribute("msg");
if (msg == null) {
    msg = (String) session.getAttribute("msg");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
    <title>Aashray-UniTrust Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#8B0000;
    --brand-hover:#B22222;
    --brand-light:#FDECEC;
}

body{
    background:
      linear-gradient(rgba(139,0,0,0.65), rgba(139,0,0,0.65)),
      url("img/carousel-1.jpg");
    background-size:cover;
    background-position:center;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'Segoe UI', sans-serif;
}

.bank-card{
    background:#fff;
    border-radius:15px;
    padding:35px;
    max-width:500px;
    width:100%;
    box-shadow:0 15px 40px rgba(0,0,0,0.25);
    animation:fadeIn 0.6s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(12px);}
    to{opacity:1; transform:translateY(0);}
}

.bank-title{
    color:var(--brand);
    font-weight:700;
}

.form-control{
    border-radius:8px;
}

.form-control:focus{
    border-color:var(--brand);
    box-shadow:0 0 0 0.12rem rgba(139,0,0,0.25);
}

.btn-danger{
    background:var(--brand);
    border:none;
    border-radius:8px;
    font-weight:600;
}

.btn-danger:hover{
    background:var(--brand-hover);
    box-shadow:0 6px 14px rgba(139,0,0,0.35);
}

.info-box{
    background:var(--brand-light);
    border-radius:10px;
    padding:15px;
    margin-bottom:20px;
}
</style>
</head>

<body>

<div class="bank-card">

<div class="text-center mb-4">
    <i class="fa fa-minus-circle fa-3x mb-2" style="color:#8B0000"></i>
    <h3 class="bank-title">Aashray-UniTrust Bank</h3>
    <p class="text-muted">Admin Withdraw Panel</p>
</div>

<% if(msg != null){ %>
<div class="alert alert-warning text-center">
    <%= msg %>
</div>
<%
session.removeAttribute("msg");
request.removeAttribute("msg");
} %>

<%-- ================= STEP 1: FETCH ACCOUNT ================= --%>
<% if(account == null){ %>

<form action="fetchAccountForWithdraw" method="post">

    <div class="form-floating mb-3">
        <input type="text" name="accountNo" class="form-control"
               placeholder="Account Number" required>
        <label>Account Number</label>
    </div>

    <button class="btn btn-danger w-100 py-2">
        Fetch Account Details
    </button>

</form>

<% } %>

<%-- ================= STEP 2: SHOW DETAILS + WITHDRAW ================= --%>
<% if(user != null && account != null){ %>

<div class="info-box">
    <p><b>Account Holder :</b> <%= user.getFname() %> <%= user.getLname() %></p>
    <p><b>Email :</b> <%= user.getEmail() %></p>
    <p><b>Account No :</b> <%= account.getAccountNo() %></p>
    <p><b>Current Balance :</b> ₹ <%= account.getOpeningBalance() %></p>
</div>

<form action="confirmWithdraw" method="post">

    <input type="hidden" name="accountNo"
           value="<%= account.getAccountNo() %>"/>

    <div class="form-floating mb-3">
        <input type="number" name="amount" class="form-control"
               placeholder="Withdraw Amount"
               min="1"
               max="<%= account.getOpeningBalance() %>"
               required>
        <label>Withdraw Amount</label>
    </div>

    <button class="btn btn-danger w-100 py-2">
        Confirm Withdraw
    </button>

</form>

<% } %>

<div class="text-center mt-4">
    <a href="admin-Dashboard" class="btn btn-secondary">
        ← Back to Dashboard
    </a>
</div>

</div>

</body>
</html>
