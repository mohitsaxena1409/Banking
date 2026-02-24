<%
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("signIn");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Transfer Money | Aashray-UniTrust Bank</title>

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

/* Back Button */
.back-btn{
    position:absolute;
    top:25px;
    left:25px;
}
.back-btn a{
    background:#fff;
    color:#011A41;
    padding:8px 14px;
    border-radius:12px;
    font-weight:600;
    text-decoration:none;
    box-shadow:0 8px 18px rgba(0,0,0,.25);
    transition:.3s;
}
.back-btn a:hover{
    background:var(--light);
    transform:translateX(-4px);
}

/* Card UI */
.card-ui{
    background:#fff;
    border-radius:18px;
    box-shadow:0 15px 30px rgba(0,0,0,.25);
    overflow:hidden;
}
.header{
    background:var(--brand);
    color:#fff;
    padding:22px;
    text-align:center;
}
.header i{
    font-size:34px;
    margin-bottom:8px;
}
label{
    font-weight:600;
}
.btn-bank{
    background:var(--brand);
    color:#fff;
    font-weight:600;
}
.btn-bank:hover{
    background:#000f2e;
}
</style>
</head>

<body>

<!-- 🔙 BACK BUTTON -->


<div class="container d-flex justify-content-center align-items-center py-5">
<div class="col-md-5">

<div class="card-ui">

<!-- HEADER -->
<div class="header">
    <i class="fa fa-paper-plane"></i>
    <h5 class="fw-bold mb-1">Transfer Money</h5>
</div>

<!-- FORM BODY -->
<div class="p-4">

<form action="transferMoney" method="post">

<div class="mb-3">
    <label>Beneficiary Account Number</label>
    <input type="text" name="toAccount" class="form-control"
           placeholder="Enter Account Number" required>
</div>

<div class="mb-3">
    <label>Amount (₹)</label>
    <input type="number" name="amount" class="form-control"
           placeholder="Enter Amount" required>
</div>

<div class="mb-4">
    <label>Transfer Type</label>
    <select name="mode" class="form-select" required>
        <option value="NEFT">NEFT</option>
        <option value="RTGS">RTGS</option>
    </select>
</div>

<button type="submit" class="btn btn-bank w-100 py-2">
    <i class="fa fa-exchange-alt me-2"></i>Transfer Money
</button>

</form>

</div>
</div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
