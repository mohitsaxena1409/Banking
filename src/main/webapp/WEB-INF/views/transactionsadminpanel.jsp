<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bank.pojo.Transaction"%>
<%@ page import="com.bank.pojo.Users"%>

<%
Users admin = (Users) session.getAttribute("loggedUser");
if (admin == null) {
    response.sendRedirect("signIn");
    return;
}

List<Transaction> txList =
    (List<Transaction>) request.getAttribute("txList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>All Transactions | Admin Panel</title>

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
    padding:20px;
    border-radius:16px;
    text-align:center;
    margin-bottom:25px;
}
.card-ui{
    background:#fff;
    padding:22px;
    border-radius:18px;
    box-shadow:0 15px 30px rgba(0,0,0,.2);
}
.table thead th{
    background:var(--light);
}
.amount{ font-weight:600; }
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
<i class="fa fa-exchange-alt fa-3x mb-2"></i>
<h3>All Bank Transactions</h3>
<small>Admin Panel | Aashray-UniTrust Bank</small>
</div>

<div class="card-ui">

<div class="table-responsive">
<table class="table table-bordered table-hover align-middle text-center">
<thead>
<tr>
<th>#</th>
<th>From Account</th>
<th>To Account</th>
<th>Amount (₹)</th>
<th>Mode</th>
<th>Status</th>
<th>Reference ID</th>
<th>Date</th>
<th>Action</th>

</tr>
</thead>

<tbody>
<%
if (txList != null && !txList.isEmpty()) {
int i = 1;
for (Transaction t : txList) {
%>
<tr>
<td><%= i++ %></td>
<td><%= t.getFromAccount() %></td>
<td><%= t.getToAccount() %></td>
<td class="amount">₹ <%= t.getAmount() %></td>

<td>
<span class="badge
<%= "DEPOSIT".equalsIgnoreCase(t.getMode()) ? "bg-success" :
    "WITHDRAW".equalsIgnoreCase(t.getMode()) ? "bg-danger" :
    "NEFT".equalsIgnoreCase(t.getMode()) ? "bg-primary" :
    "RTGS".equalsIgnoreCase(t.getMode()) ? "bg-purple" :
    "bg-secondary" %>">
<%= t.getMode() %>
</span>
</td>



<td>
<span class="badge
<%= "SUCCESS".equalsIgnoreCase(t.getStatus()) ? "bg-success" :
    "FAILED".equalsIgnoreCase(t.getStatus()) ? "bg-danger" :
    "bg-warning text-dark" %>">
<%= t.getStatus() %>
</span>
</td>
<td><%= t.getReferenceId() %></td>
<td><%= t.getCreatedAt() %></td>
<td>
<button class="btn btn-sm btn-outline-dark"
        onclick="printReceipt(
            '<%= t.getFromAccount() %>',
            '<%= t.getToAccount() %>',
            '<%= t.getAmount() %>',
            '<%= t.getMode() %>',
            '<%= t.getStatus() %>',
            '<%= t.getReferenceId() %>',
            '<%= t.getCreatedAt() %>'
        )">
<i class="fa fa-print"></i>
</button>
</td>

</tr>
<%
}
} else {
%>
<tr>
<td colspan="8" class="text-muted">
No Transactions Found
</td>
</tr>
<%
}
%>
</tbody>
</table>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function printReceipt(fromAcc, toAcc, amount, mode, status, refId, date) {

    let receiptWindow = window.open('', '', 'width=800,height=600');

    receiptWindow.document.write(`
        <html>
        <head>
        <title>Transaction Receipt</title>
        <style>
            body{
                font-family:Segoe UI, sans-serif;
                padding:30px;
            }
            .receipt{
                border:2px solid #011A41;
                padding:25px;
                border-radius:12px;
            }
            .bank{
                text-align:center;
                margin-bottom:20px;
            }
            .bank h2{ color:#011A41; margin:0; }
            .row{
                display:flex;
                justify-content:space-between;
                padding:8px 0;
                border-bottom:1px dashed #ccc;
            }
            .row:last-child{ border-bottom:none; }
            .label{ font-weight:600; }
            .footer{
                text-align:center;
                margin-top:25px;
                font-size:13px;
                color:#555;
            }
        </style>
        </head>

        <body onload="window.print(); window.close();">

        <div class="receipt">
            <div class="bank">
                <h2>Aashray-UniTrust Bank</h2>
                <p><b>Transaction Receipt</b></p>
            </div>

            <div class="row"><span class="label">From Account</span><span>${fromAcc}</span></div>
            <div class="row"><span class="label">To Account</span><span>${toAcc}</span></div>
            <div class="row"><span class="label">Amount</span><span>₹ ${amount}</span></div>
            <div class="row"><span class="label">Mode</span><span>${mode}</span></div>
            <div class="row"><span class="label">Status</span><span>${status}</span></div>
            <div class="row"><span class="label">Reference ID</span><span>${refId}</span></div>
            <div class="row"><span class="label">Date</span><span>${date}</span></div>

            <div class="footer">
                This is a system generated receipt.<br>
                Thank you for banking with us.
            </div>
        </div>

        </body>
        </html>
    `);

    receiptWindow.document.close();
}
</script>

</body>
</html>
