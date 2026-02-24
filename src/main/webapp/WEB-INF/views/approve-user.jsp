<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bank.pojo.Users"%>

<%
Users u = (Users) request.getAttribute("user");
String accountNo = (String) request.getAttribute("accountNo");
String username  = (String) request.getAttribute("username");
String password  = (String) request.getAttribute("password");

if (u == null) {
    response.sendRedirect("admin-Dashboard");
    return;
}
String msg = (String) request.getAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Approve Account | Aashray-UniTrust Bank</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-light:#E7EEFA;
}
body{
    background:var(--brand-light);
    font-family:'Segoe UI',sans-serif;
    margin:0;
}

/* LEFT PANEL */
.bank-panel{
    width:22%;
    position:fixed;
    height:100vh;
    background:linear-gradient(180deg,#011A41,#022B6F);
    color:#fff;
    padding:40px 30px;
}
.bank-panel h4{font-weight:700}

/* RIGHT AREA */
.content-area{
    margin-left:22%;
    padding:35px;
}

/* CARD */
.desk-card{
    background:#fff;
    border-radius:16px;
    padding:30px;
    box-shadow:0 15px 35px rgba(0,0,0,.15);
}

/* TITLES */
.section-title{
    background:var(--brand-light);
    color:var(--brand);
    padding:6px 14px;
    border-radius:20px;
    font-size:14px;
    font-weight:600;
    display:inline-block;
    margin:26px 0 14px;
}

/* FORM */
label{font-size:13px;font-weight:600}
.form-control,.form-select{
    border-radius:8px;
    font-size:14px;
}
.form-control:focus,.form-select:focus{
    border-color:var(--brand);
    box-shadow:0 0 0 .12rem rgba(1,26,65,.25);
}
.readonly{
    background:#f8f9fa;
}

/* HEADER */
.header-box{
    border-left:6px solid var(--brand);
    padding-left:15px;
}
</style>
</head>

<body>

<!-- LEFT PANEL -->
<div class="bank-panel">
    <i class="fa fa-university fa-3x mb-3"></i>
    <h4>Aashray-UniTrust Bank</h4>
    <p class="small">Admin Desk – Account Approval</p>
    <hr>
</div>

<!-- RIGHT CONTENT -->
<div class="content-area">
<div class="desk-card">

<div class="header-box mb-3">
    <h4 class="mb-0" style="color:#011A41;font-weight:700">
        Approve User & Create Bank Account
    </h4>
    <small class="text-muted">Final admin confirmation screen</small>
</div>

<% if (msg != null) { %>
<div class="alert alert-info text-center">
    <%= msg %>
</div>
<% } %>

<!-- ================= USER DETAILS ================= -->
<span class="section-title">User Details</span>

<div class="row">
    <div class="col-md-4 mb-3">
        <label>Full Name</label>
        <input class="form-control readonly"
               value="<%=u.getFname()%> <%=u.getLname()%>" readonly>
    </div>
    <div class="col-md-4 mb-3">
        <label>Email</label>
        <input class="form-control readonly" name="email"
               value="<%=u.getEmail()%>" readonly >
    </div>
    <div class="col-md-4 mb-3">
        <label>Phone</label>
        <input class="form-control readonly"
               value="<%=u.getPhone()%>" readonly>
    </div>
</div>

<div class="row">
    <div class="col-md-4 mb-3">
        <label>DOB</label>
        <input class="form-control readonly"
               value="<%=u.getDob()%>" readonly>
    </div>
    <div class="col-md-4 mb-3">
        <label>Gender</label>
        <input class="form-control readonly"
               value="<%=u.getGender()%>" readonly>
    </div>
    <div class="col-md-4 mb-3">
        <label>Account Type</label>
        <input class="form-control readonly"
               value="<%=u.getAccounttype()%>" readonly>
    </div>
</div>

<div class="mb-3">
    <label>Address</label>
    <input class="form-control readonly"
           value="<%=u.getAddress()%>, <%=u.getCity()%>, <%=u.getState()%> - <%=u.getPincode()%>"
           readonly>
</div>

<!-- ================= BANK DETAILS ================= -->
<span class="section-title">Bank Account Details</span>

<form action="finalApprove" method="post">
<input type="hidden" name="id" value="<%=u.getId()%>">

    <input type="hidden" name="id" value="<%=u.getId()%>">
    <input type="hidden" name="email" value="<%=u.getEmail()%>">
    <input type="hidden" name="fname" value="<%=u.getFname()%>">


<div class="row">
    <div class="col-md-6 mb-3">
        <label>Account Number</label>
        <input class="form-control readonly"
               name="accountno"
               value="<%=accountNo%>" readonly>
    </div>

    <div class="col-md-6 mb-3">
        <label>Branch</label>
        <select name="branch" class="form-select" required>
            <option value="">-- Select Branch --</option>
            <option>DELHI</option>
            <option>MUMBAI</option>
            <option>BHOPAL</option>
            <option>INDORE</option>
            <option>PUNE</option>
        </select>
    </div>

    <div class="col-md-6 mb-3">
        <label>Initial Balance (₹)</label>
        <input type="number" name="balance"
               class="form-control"
               min="500" required>
    </div>

    <div class="col-md-6 mb-3">
        <label>Username</label>
        <input class="form-control readonly"
               name="username"
               value="<%=username%>" readonly>
    </div>

    <div class="col-md-6 mb-3">
        <label>Password</label>
        <input class="form-control"
               name="password"
               value="<%=password%>" readonly>
    </div>
</div>

<hr>

<div class="d-flex justify-content-between">
    <a href="admin-Dashboard" class="btn btn-outline-secondary px-4">
    ⬅ Back
</a>

    <button class="btn btn-success px-4">
        ✔ Final Approve & Create Account
    </button>
</div>

</form>

</div>
</div>

</body>
</html>
