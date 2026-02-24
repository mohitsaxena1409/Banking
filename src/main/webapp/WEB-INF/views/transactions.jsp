<%@page import="com.bank.pojo.Transaction"%>
<%@page import="java.util.List"%>
<%@ page import="com.bank.pojo.Users"%>
<%@ page import="com.bank.pojo.BankAccount"%>

<%
List<Transaction> list =
    (List<Transaction>) request.getAttribute("transactions");

Users user =
    (Users) request.getAttribute("user");

BankAccount account =
    (BankAccount) request.getAttribute("account");
%>


<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Transaction History | Passbook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:'Segoe UI',sans-serif;
}
.header{
    background:#011A41;
    color:#fff;
    padding:20px;
    border-radius:14px;
    margin-bottom:20px;
}
.card-ui{
    background:#fff;
    padding:20px;
    border-radius:14px;
    box-shadow:0 10px 25px rgba(0,0,0,.1);
}
.table thead th{
    background:#e7eefa;
}
.amount{ font-weight:600; }

@media print{
    @page{
        size: A4;
        margin: 8mm;   /* ← yahan side space control hota hai */
    }

    body{
        background:#fff !important;
        color:#000;
        font-family:"Times New Roman", serif;
        font-size:12px;
        margin:0 !important;
        padding:0 !important;
    }

    .container{
        width:100% !important;
        max-width:100% !important;
        margin:0 !important;
        padding:0 !important;
    }

    .card-ui{
        box-shadow:none !important;
        border:none !important;
        padding:0 !important;
    }

    .no-print{
        display:none !important;
    }

    .header{
        background:none !important;
        color:#000 !important;
        border-bottom:2px solid #000;
        border-radius:0;
        margin-bottom:10px;
        padding:5px 0;
    }

    table{
        width:100% !important;
        border-collapse:collapse !important;
    }

    table th, table td{
        border:1px solid #000 !important;
        background:none !important;
        padding:4px !important;
    }
}

</style>

<script>
function printPassbook(){
    window.print();
}
</script>

</head>

<body>

<div class="container mt-4">

<div class="header d-flex justify-content-between align-items-center no-print">
    <div>
        <i class="fa fa-book fa-2x"></i>
        <h4 class="mb-0">Transaction Passbook</h4>
        <small>Aashray-UniTrust Bank</small>
    </div>
    <div>
        <button onclick="printPassbook()" class="btn btn-light me-2">
            <i class="fa fa-print"></i> Print
        </button>
        
    </div>
</div>

<div class="card-ui">

<div class="mb-3">
    <strong>Bank:</strong> Aashray-UniTrust Bank<br>
    <strong>Statement Generated:</strong> <%= new java.util.Date() %>
</div>
<div class="row mb-3">
    <div class="col-md-6">
        <strong>Account Holder:</strong>
        <%= user != null ? user.getFname() : "N/A" %><br>

        <strong>Account Number:</strong>
        <%= account != null ? account.getAccountNo() : "N/A" %><br>

    </div>

    <div class="col-md-6 text-end">
        <strong>Total Balance</strong>
        <h5 class="fw-bold">
            &#8377; <%= account != null ? account.getOpeningBalance() : 0 %>
        </h5>

        <small>
            Statement Generated:
            <%= new java.util.Date() %>
        </small>
    </div>
</div>

<hr>

<table class="table table-bordered table-hover text-center">
<thead>
<tr>
<th>Date</th>
<th>From</th>
<th>To</th>
<th>Amount</th>
<th>Mode</th>
<th>Status</th>
</tr>
</thead>

<tbody>
<%
if(list != null && !list.isEmpty()){
for(Transaction t : list){
%>
<tr>
<td><%= t.getCreatedAt() %></td>
<td><%= t.getFromAccount() %></td>
<td><%= t.getToAccount() %></td>
<td class="amount">&#8377 <%= t.getAmount() %></td>
<td><%= t.getMode() %></td>
<td><%= t.getStatus() %></td>
</tr>
<%
}
}else{
%>
<tr>
<td colspan="6">No Transactions Found</td>
</tr>
<% } %>
</tbody>
</table>

</div>
</div>

</body>
</html>
