<%@ page import="com.bank.pojo.Users"%>
<%@ page import="com.bank.pojo.BankAccount"%>

<%
Users u = (Users) session.getAttribute("loggedUser");
BankAccount acc = (BankAccount) request.getAttribute("account");

String msg = (String) session.getAttribute("msg");
if (msg != null) {
    session.removeAttribute("msg"); // refresh safe
}

boolean isError = false;
if (msg != null) {
    if (
        msg.equals("Invalid beneficiary account") ||
        msg.equals("Insufficient balance") ||
        msg.equals("RTGS minimum amount is 2,00,000") ||
        msg.equals("Your account is blocked. Transaction not allowed.") ||
        msg.equals("Beneficiary account is blocked. Payment not allowed.")
    ) {
        isError = true;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>User Dashboard | Aashray-UniTrust Bank</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-hover:#03316E;
    --brand-light:#E7EEFA;
}

body{
    background:linear-gradient(rgba(1,26,65,.6),rgba(1,26,65,.6)),
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
    margin-bottom:28px;
}

.card-ui{
    background:#fff;
    border-radius:18px;
    padding:20px;
    box-shadow:0 15px 35px rgba(0,0,0,.18);
}

.section-title{
    font-weight:700;
    color:var(--brand);
}

.table th{
    background:var(--brand-light);
    width:40%;
}

/* ACTION BUTTONS */
.account-actions{
    display:flex;
    gap:10px;
    margin-top:12px;
}
.action-btn{
    flex:1;
    padding:10px 6px;
    text-align:center;
    border-radius:12px;
    color:#fff;
    font-size:14px;
    font-weight:600;
    text-decoration:none;
}
.action-btn i{display:block;font-size:18px;}
.withdraw{background:#dc3545;}
.transactions{background:#6c757d;}
.update{background:#0d6efd;}
.action-btn:hover{opacity:.9;color:#fff}

/* DOC BUTTON */
.btn-doc{
    border:2px solid #0d6efd;
    color:#0d6efd;
    background:#fff;
    font-weight:600;
    border-radius:10px;
    padding:9px;
}
.btn-doc:hover{
    background:#0d6efd;
    color:#fff;
}

/* LOGOUT */
.btn-logout{
    background:#212529;
    color:#fff;
    border-radius:12px;
    font-weight:600;
    padding:10px;
}
.btn-logout:hover{background:#000}
</style>
</head>

<body>

<div class="container py-4">

<!-- HEADER -->
<div class="header text-center">
    <i class="fa fa-university fa-3x mb-2"></i>
    <h3>Welcome, <%= u.getFname() %> <%= u.getLname() %></h3>
    <small>User Dashboard | Aashray-UniTrust Bank</small>
</div>

<div class="row g-4">

<!-- PERSONAL -->
<div class="col-xl-4 col-lg-6">
<div class="card-ui">
<h5 class="section-title mb-3"><i class="fa fa-user me-2"></i>Personal Details</h5>
<table class="table table-bordered">
<tr><th>Email</th><td><%= u.getEmail() %></td></tr>
<tr><th>Phone</th><td><%= u.getPhone() %></td></tr>
<tr><th>DOB</th><td><%= u.getDob() %></td></tr>
<tr><th>Gender</th><td><%= u.getGender() %></td></tr>
<tr><th>Aadhar</th><td><%= u.getAadharno() %></td></tr>
<tr><th>PAN</th><td><%= u.getPanno() %></td></tr>
</table>
</div>
</div>

<!-- BANK -->
<div class="col-xl-4 col-lg-6">
<div class="card-ui">
<h5 class="section-title mb-3"><i class="fa fa-credit-card me-2"></i>Bank Account</h5>

<% if(acc!=null){ %>
<table class="table table-bordered">
<tr><th>Account No</th><td><%= acc.getAccountNo() %></td></tr>
<tr><th>IFSC</th><td><%= acc.getIfsc() %></td></tr>
<tr><th>Branch</th><td><%= acc.getBranch() %></td></tr>
<tr><th>Status</th><td><%= acc.getStatus() %></td></tr>
</table>

<div class="account-actions">
    <a href="transfer-money" class="action-btn withdraw">
        <i class="fa fa-minus-circle"></i>Transfer
    </a>
    <a href="view-transactions" class="action-btn transactions">
        <i class="fa fa-list"></i>Transactions
    </a>
    <a href="update-profile" class="action-btn update">
        <i class="fa fa-user-edit"></i>Update
    </a>
</div>

<% } else { %>
<div class="alert alert-warning text-center">Account not activated</div>
<% } %>

</div>
</div>

<!-- DOCUMENTS -->
<div class="col-xl-4 col-lg-12">
<div class="card-ui text-center">
<h5 class="section-title mb-3"><i class="fa fa-folder me-2"></i>Documents</h5>

<div class="d-grid gap-2">
<button class="btn btn-doc" onclick="showDoc('Photo','<%=request.getContextPath()%>/users/<%=u.getPhoto()%>')">
View Photo</button>

<button class="btn btn-doc" onclick="showDoc('Signature','<%=request.getContextPath()%>/Signature/<%=u.getSignature()%>')">
View Signature</button>

<button class="btn btn-doc" onclick="showDoc('Aadhar','<%=request.getContextPath()%>/Aadhar/<%=u.getAadhardoc()%>')">
View Aadhar</button>

<button class="btn btn-doc" onclick="showDoc('PAN','<%=request.getContextPath()%>/PAN/<%=u.getPandoc()%>')">
View PAN</button>
</div>

<hr>
<button class="btn btn-logout w-100" onclick="location.href='logout'">
<i class="fa fa-sign-out-alt me-2"></i>Logout
</button>
</div>
</div>

</div>
</div>

<!-- DOCUMENT MODAL -->
<div class="modal fade" id="docModal">
<div class="modal-dialog modal-xl modal-dialog-centered">
<div class="modal-content">
<div class="modal-header bg-dark text-white">
<h5 id="docTitle"></h5>
<button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body text-center">
<img id="docImg" style="max-width:100%;max-height:80vh;cursor:zoom-in"
onclick="toggleZoom(this)">
</div>
</div>
</div>
</div>

<!-- MESSAGE MODAL -->
<% if(msg != null){ %>
<div class="modal fade" id="msgModal">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content" style="border-radius:16px;overflow:hidden;">

<div class="modal-header" style="background:#011A41;color:#fff;">
<h5 class="modal-title">
<i class="fa <%= isError ? "fa-times-circle" : "fa-check-circle" %> me-2"></i>
<%= isError ? "Error" : "Notification" %>
</h5>
<button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body text-center py-4">
<i class="fa <%= isError ? "fa-times-circle" : "fa-check-circle" %> fa-3x mb-3"
style="color:<%= isError ? "#dc3545" : "#011A41" %>"></i>
<p class="fw-semibold mb-0"><%= msg %></p>
</div>

<div class="modal-footer justify-content-center">
<button class="btn px-4" style="background:#011A41;color:#fff;"
data-bs-dismiss="modal">OK</button>
</div>

</div>
</div>
</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function showDoc(title,src){
document.getElementById("docTitle").innerText=title;
let img=document.getElementById("docImg");
img.src=src; img.style.transform="scale(1)";
new bootstrap.Modal(document.getElementById("docModal")).show();
}
function toggleZoom(img){
img.style.transform = img.style.transform==="scale(2)"?"scale(1)":"scale(2)";
}

document.addEventListener("DOMContentLoaded",function(){
let modal=document.getElementById("msgModal");
if(modal){ new bootstrap.Modal(modal).show(); }
});
</script>

</body>
</html>
