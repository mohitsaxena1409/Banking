<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.bank.pojo.BankAccount,com.bank.pojo.Users" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/titleLogo.png" type="image/png">
<title>Admin Deposit | Aashray-UniTrust Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-hover:#03316E;
    --brand-light:#E7EEFA;
}

/* ===== BODY ===== */
body{
    background:
      linear-gradient(rgba(1,26,65,0.6), rgba(1,26,65,0.6)),
      url("img/carousel-1.jpg");
    background-size:cover;
    background-position:center;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'Segoe UI', sans-serif;
}

/* ===== CARD ===== */
.bank-card{
    background:#fff;
    border-radius:15px;
    padding:35px;
    max-width:480px;
    width:100%;
    box-shadow:0 15px 40px rgba(0,0,0,0.25);
    animation:fadeIn 0.6s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(12px);}
    to{opacity:1; transform:translateY(0);}
}

/* ===== TITLE ===== */
.bank-title{
    color:var(--brand);
    font-weight:700;
}

/* ===== INPUT ===== */
.form-control{
    border-radius:8px;
}

.form-control:focus{
    border-color:var(--brand);
    box-shadow:0 0 0 0.12rem rgba(1,26,65,0.25);
}

/* ===== BUTTON ===== */
.btn-primary{
    background:var(--brand);
    border:none;
    border-radius:8px;
    font-weight:600;
}

.btn-primary:hover{
    background:var(--brand-hover);
    box-shadow:0 6px 14px rgba(1,26,65,0.35);
}

/* ===== INFO BOX ===== */
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
    <i class="fa fa-university fa-3x mb-2" style="color:#011A41"></i>
    <h3 class="bank-title">Aashray-UniTrust Bank</h3>
    <p class="text-muted">Admin Deposit Panel</p>
</div>

<%
String msg = (String) request.getAttribute("msg");
if (msg != null) {
%>
<div class="alert alert-danger text-center">
    <%= msg %>
</div>
<%
}
%>

<%
BankAccount acc = (BankAccount) request.getAttribute("account");
Users u = (Users) request.getAttribute("user");

/* ================= STEP 1: ENTER ACCOUNT NUMBER ================= */
if (acc == null) {
%>

<form action="fetchAccountForDeposit" method="post">

    <div class="form-floating mb-3">
        <input type="text" name="accountNo" class="form-control"
               placeholder="Account Number" required>
        <label>Account Number</label>
    </div>

    <button class="btn btn-primary w-100 py-2">
        Fetch Account Details
    </button>

</form>

<%
}
/* ================= STEP 2: SHOW DETAILS + DEPOSIT ================= */
else if (acc != null && u != null) {
%>

<div class="info-box">
    <p><b>Account Holder :</b> <%= u.getFname() %> <%= u.getLname() %></p>
    <p><b>Email :</b> <%= u.getEmail() %></p>
    <p><b>Account No :</b> <%= acc.getAccountNo() %></p>
    <p><b>Current Balance :</b> ₹ <%= acc.getOpeningBalance() %></p>
</div>

<form action="confirmDeposit" method="post">

    <input type="hidden" name="accountNo"
           value="<%= acc.getAccountNo() %>"/>

    <div class="form-floating mb-3">
        <input type="number" name="amount" class="form-control"
               placeholder="Deposit Amount" required>
        <label>Deposit Amount</label>
    </div>

    <button class="btn btn-primary w-100 py-2">
        Confirm Deposit
    </button>

</form>

<%
}
%>

</div>

</body>
</html>
