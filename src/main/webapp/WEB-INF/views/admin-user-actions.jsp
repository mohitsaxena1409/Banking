<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.bank.pojo.Users"%>
<%@ page import="com.bank.pojo.BankAccount"%>
<%@ page import="com.bank.pojo.Transaction"%>

<%
Users user = (Users) request.getAttribute("user");
BankAccount acc = (BankAccount) request.getAttribute("account");
List<Transaction> txList = (List<Transaction>) request.getAttribute("txList");

if(user == null || acc == null){
    response.sendRedirect("admin-Dashboard");
    return;
}
String msg = (String) session.getAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Admin User Panel | Aashray-UniTrust Bank</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
:root{ --brand:#011A41; }

body{
    background:linear-gradient(120deg,#011A41,#022f78);
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}

.glass{
    background:#fff;
    border-radius:18px;
    box-shadow:0 18px 40px rgba(0,0,0,.25);
}

.header{ color:#fff; padding:25px 0; }
.balance{ font-size:22px;font-weight:700;color:#198754; }

.no-print{ display:inline-block; }
</style>
</head>

<body>
<div class="container py-4">

<!-- HEADER -->
<div class="header text-center">
    <i class="fa-solid fa-user-shield fa-2x mb-2"></i>
    <h3>Admin User Management</h3>
    <small>Aashray-UniTrust Bank</small>
</div>

<% if(msg!=null){ %>
<div class="alert alert-success alert-dismissible fade show">
    <%=msg%>
    <button class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% session.removeAttribute("msg"); } %>
<!-- PASSBOOK + HOME BUTTONS -->
<div class="d-flex justify-content-end gap-2 mb-3">

    <button class="btn btn-light fw-semibold px-4 shadow-sm no-print"
            style="border-radius:30px"
            onclick="printFullPassbook()">
        <i class="fa fa-book me-2 text-primary"></i>
        Print Full Passbook
    </button>

    <a href="admin-Dashboard"
       class="btn btn-light fw-semibold px-4 shadow-sm no-print"
       style="border-radius:30px; text-decoration:none;">
        <i class="fa fa-home me-2 text-primary"></i>
        Home
    </a>

</div>
<!-- USER SUMMARY -->
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="glass p-3">
            <h6>Customer</h6>
            <b><%=user.getFname()%> <%=user.getLname()%></b>
        </div>
    </div>
    <div class="col-md-4">
        <div class="glass p-3">
            <h6>Account No</h6>
            <b><%=acc.getAccountNo()%></b>
        </div>
    </div>
    <div class="col-md-4">
        <div class="glass p-3">
            <h6>Balance</h6>
            <div class="balance">₹ <%=acc.getOpeningBalance()%></div>
        </div>
    </div>
</div>




<!-- ACTIONS -->
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <button class="btn btn-success w-100" onclick="showDeposit()">Deposit</button>
    </div>
    <div class="col-md-4">
        <button class="btn btn-danger w-100" onclick="showWithdraw()">Withdraw</button>
    </div>
    <div class="col-md-4">
        <button class="btn btn-dark w-100"
        onclick="document.getElementById('txBox').scrollIntoView({behavior:'smooth'})">
        Transactions</button>
    </div>
</div>

<!-- DEPOSIT -->
<div id="depositBox" class="glass p-4 d-none mb-4">
<form action="adminDeposit" method="post">
<input type="hidden" name="accountNo"  value="<%=acc.getAccountNo()%>">
<input type="number" name="amount" placeholder="Enter Amount" class="form-control mb-3" required>
<button class="btn btn-success w-100">Confirm Deposit</button>
</form>
</div>

<!-- WITHDRAW -->
<div id="withdrawBox" class="glass p-4 d-none mb-4">
<form action="adminWithdraw" method="post">
<input type="hidden" name="accountNo"   value="<%=acc.getAccountNo()%>">
<input type="number" name="amount"  placeholder="Enter Amount" class="form-control mb-3" required>
<button class="btn btn-danger w-100">Confirm Withdraw</button>
</form>
</div>

<!-- TRANSACTIONS -->
<div id="txBox" class="glass p-4 mb-5">
<h5 class="text-primary mb-3">
<i class="fa fa-receipt me-2"></i>Transaction History
</h5>

<table class="table table-hover text-center align-middle">
<thead>
<tr>
<th>#</th><th>From</th><th>To</th><th>Amount</th>
<th>Mode</th><th>Status</th><th>Ref</th><th>Date</th>
<th>Receipt</th>
</tr>
</thead>

<tbody>
<%
int i=1;
for(Transaction t:txList){
%>
<tr>
<td><%=i++%></td>
<td><%=t.getFromAccount()%></td>
<td><%=t.getToAccount()%></td>
<td>₹ <%=t.getAmount()%></td>
<td><%=t.getMode()%></td>
<td><%=t.getStatus()%></td>
<td><%=t.getReferenceId()%></td>
<td><%=t.getCreatedAt()%></td>
<td>
<button class="btn btn-sm btn-outline-primary"
        onclick="printReceipt(this)">
<i class="fa fa-file-pdf"></i>
</button>
</td>
</tr>
<% } %>
</tbody>
</table>
</div>

</div>

<!-- ================= HIDDEN PASSBOOK ================= -->
<div id="fullPassbook" style="display:none">
    <div>
        <h4 class="text-center">Transaction Passbook</h4>
        <p>
            <b>Account Holder:</b> <%=user.getFname()%> <%=user.getLname()%><br>
            <b>Account Number:</b> <%=acc.getAccountNo()%><br>
            <b>Generated On:</b> <%=new java.util.Date()%>
        </p>

        <table>
            <tr>
                <th>Date</th><th>From</th><th>To</th>
                <th>Amount</th><th>Mode</th><th>Status</th>
            </tr>
            <%
            for(Transaction t:txList){
            %>
            <tr>
                <td><%=t.getCreatedAt()%></td>
                <td><%=t.getFromAccount()%></td>
                <td><%=t.getToAccount()%></td>
                <td>₹ <%=t.getAmount()%></td>
                <td><%=t.getMode()%></td>
                <td><%=t.getStatus()%></td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

<!-- JS -->
<script>
function hideAll(){
    depositBox.classList.add("d-none");
    withdrawBox.classList.add("d-none");
}
function showDeposit(){ hideAll(); depositBox.classList.remove("d-none"); }
function showWithdraw(){ hideAll(); withdrawBox.classList.remove("d-none"); }

function printReceipt(btn){
    let r = btn.closest("tr").children;
    let w = window.open("","","width=800,height=600");
    w.document.write(`
    <html><head><style>
    body{font-family:Segoe UI;padding:25px;}
    .box{border:2px solid #011A41;padding:20px;border-radius:10px;}
    .row{display:flex;justify-content:space-between;padding:6px 0;}
    </style></head>
    <body onload="window.print();window.close()">
    <div class="box">
    <h3 style="text-align:center">Aashray-UniTrust Bank</h3>
    <div class="row"><b>From</b><span>${r[1].innerText}</span></div>
    <div class="row"><b>To</b><span>${r[2].innerText}</span></div>
    <div class="row"><b>Amount</b><span>${r[3].innerText}</span></div>
    <div class="row"><b>Mode</b><span>${r[4].innerText}</span></div>
    <div class="row"><b>Status</b><span>${r[5].innerText}</span></div>
    <div class="row"><b>Ref ID</b><span>${r[6].innerText}</span></div>
    <div class="row"><b>Date</b><span>${r[7].innerText}</span></div>
    </div></body></html>`);
    w.document.close();
}

function printFullPassbook(){
    let c=document.getElementById("fullPassbook").innerHTML;
    let w=window.open("","","width=900,height=650");
    w.document.write(`
    <html><head><style>
    @page{size:A4;margin:12mm;}
    body{font-family:Segoe UI;}
    table{width:100%;border-collapse:collapse;}
    th,td{border:2px solid #000;padding:6px;text-align:center;}
    </style></head>
    <body onload="window.print();window.close()">${c}</body></html>`);
    w.document.close();
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
