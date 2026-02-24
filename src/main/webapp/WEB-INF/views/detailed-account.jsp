<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bank.pojo.Users"%>
<%@ page import="com.bank.pojo.BankAccount"%>

<%
Users admin = (Users) session.getAttribute("loggedUser");
if (admin == null) {
    response.sendRedirect("signIn");
    return;
}

Users u = (Users) request.getAttribute("user");
BankAccount acc = u.getAccount();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Account Details | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
}
body{
    background:#f4f6f9;
}
.card-ui{
    background:#fff;
    border-radius:16px;
    box-shadow:0 10px 25px rgba(0,0,0,.1);
    padding:25px;
}
.title{
    color:var(--brand);
    font-weight:700;
}
.table th{
    width:35%;
    background:#f1f3f6;
}
img{
    background:#fff;
    padding:6px;
}
/* KYC IMAGES */
.kyc-img{
    width:160px;
    height:160px;
    object-fit:contain;
    background:#fff;
    padding:8px;
    border-radius:14px;
    box-shadow:0 6px 14px rgba(0,0,0,.25);
    cursor:pointer;
    transition:.3s;
}
.kyc-img:hover{
    transform:scale(1.05);
}

/* CUSTOM IMAGE MODAL (same as desk page) */
.img-modal{
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.85);
    z-index:9999;
    justify-content:center;
    align-items:center;
}
.img-modal img{
    max-width:90%;
    max-height:90%;
    border-radius:12px;
    background:#fff;
    padding:10px;
}
.close-btn{
    position:absolute;
    top:20px;
    right:30px;
    font-size:34px;
    color:#fff;
    cursor:pointer;
}
.kyc-img{
    height:130px;
    width:100%;
    object-fit:cover;
    border-radius:10px;
    border:1px solid #ddd;
    cursor:pointer;
}
.zoom-img:hover{
    transform:scale(1.05);
    transition:.3s;
}


</style>
</head>
<!-- IMAGE ZOOM MODAL -->
<div class="modal fade" id="imageModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title">Document Preview</h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <img id="zoomImage"
             class="img-fluid rounded"
             style="max-height:80vh;">
      </div>
    </div>
  </div>
</div>

<body>

<div class="container py-4">

<h4 class="title mb-3">
<i class="fa fa-id-card me-2"></i>Account & Customer Details
</h4>

<div class="row g-4">

<!-- USER DETAILS -->
<div class="col-lg-6">
<div class="card-ui">
<h6 class="title">Customer Information</h6>
<table class="table table-bordered mt-3">
<tr><th>Name</th><td><%= u.getFname() %> <%= u.getLname() %></td></tr>
<tr><th>Email</th><td><%= u.getEmail() %></td></tr>
<tr><th>Phone</th><td><%= u.getPhone() %></td></tr>
<tr><th>Gender</th><td><%= u.getGender() %></td></tr>
<tr><th>DOB</th><td><%= u.getDob() %></td></tr>
<tr><th>Address</th><td><%= u.getAddress() %>, <%= u.getCity() %></td></tr>
<tr><th>Aadhaar</th><td><%= u.getAadharno() %></td></tr>
<tr><th>PAN</th><td><%= u.getPanno() %></td></tr>
</table>
</div>
</div>

<!-- ACCOUNT DETAILS -->
<div class="col-lg-6">
<div class="card-ui">
<h6 class="title">Bank Account Information</h6>
<table class="table table-bordered mt-3">
<tr><th>Account No</th><td><%= acc.getAccountNo() %></td></tr>
<tr><th>Account Type</th><td><%= acc.getAccountType() %></td></tr>
<tr><th>Balance</th><td>₹ <%= acc.getOpeningBalance() %></td></tr>
<tr><th>IFSC</th><td><%= acc.getIfsc() %></td></tr>
<tr><th>Branch</th><td><%= acc.getBranch() %></td></tr>
<tr><th>ATM Facility</th>
<td><%= acc.getAtmFacility()==1 ? "YES" : "NO" %></td></tr>
<tr><th>Cheque Book</th>
<td><%= acc.getChequeBook()==1 ? "YES" : "NO" %></td></tr>
<tr><th>Status</th>
<td>
<% if("ACTIVE".equalsIgnoreCase(acc.getStatus())){ %>
<span class="badge bg-success">ACTIVE</span>
<% } else { %>
<span class="badge bg-danger">BLOCKED</span>
<% } %>
</td>
</tr>
</table>
</div>
</div>

</div>
<!-- KYC & DOCUMENTS -->
<div class="col-12">
<div class="card-ui mt-4">

<h6 class="title mb-3">
<i class="fa fa-folder-open me-2"></i>KYC & Documents
</h6>

<div class="row g-4 text-center">

<!-- PHOTO -->
<div class="col-md-3">
<p class="fw-bold">Photo</p>
<img src="<%=request.getContextPath()%>/users/<%=u.getPhoto()%>"
     class="kyc-img zoom-img">
</div>

<!-- SIGNATURE -->
<div class="col-md-3">
<p class="fw-bold">Signature</p>
<img src="<%=request.getContextPath()%>/Signature/<%=u.getSignature()%>"
     class="kyc-img zoom-img">
</div>

<!-- AADHAAR -->
<div class="col-md-3">
<p class="fw-bold">Aadhaar</p>
<img src="<%=request.getContextPath()%>/Aadhar/<%=u.getAadhardoc()%>"
     class="kyc-img zoom-img">
</div>

<!-- PAN -->
<div class="col-md-3">
<p class="fw-bold">PAN</p>
<img src="<%=request.getContextPath()%>/PAN/<%=u.getPandoc()%>"
     class="kyc-img zoom-img">
</div>

</div>
</div>
</div>


</div>

</body>
<!-- IMAGE ZOOM MODAL -->
<div class="img-modal" id="imgModal">
    <span class="close-btn" onclick="closeImg()">×</span>
    <img id="modalImg">
</div>
<script>
const modal = document.getElementById("imgModal");
const modalImg = document.getElementById("modalImg");

document.querySelectorAll(".zoom-img").forEach(img=>{
    img.onclick = () => {
        modal.style.display = "flex";
        modalImg.src = img.src;
    }
});

function closeImg(){
    modal.style.display = "none";
}

modal.onclick = e => {
    if(e.target === modal){
        closeImg();
    }
}
</script>


</html>
