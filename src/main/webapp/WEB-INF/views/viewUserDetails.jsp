<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bank.pojo.Users"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Account Verification | Aashray-UniTrust Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --primary:#0A1F44;
    --accent:#1E88E5;
    --bg:#F4F7FC;
}
body{
    background:var(--bg);
    font-family:'Segoe UI',sans-serif;
}

/* SIDEBAR */
.sidebar{
    position:fixed;
    inset:0 auto 0 0;
    width:260px;
    background:linear-gradient(180deg,#0A1F44,#02122F);
    color:#fff;
    padding:30px 25px;
}
.sidebar h4{font-weight:700}
.sidebar p{font-size:13px;opacity:.9}

/* MAIN */
.main{
    margin-left:260px;
    padding:35px;
}

/* CARD */
.card-ui{
    background:#fff;
    border-radius:20px;
    padding:30px;
    box-shadow:0 18px 40px rgba(0,0,0,.12);
}

/* TITLES */
.section-title{
    display:inline-block;
    background:#E3ECFA;
    color:#0A1F44;
    padding:6px 14px;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
    margin:28px 0 14px;
}

/* PROFILE */
.profile-img{
    width:160px;
    height:160px;
    object-fit:cover;
    border-radius:50%;
    border:4px solid var(--accent);
    box-shadow:0 6px 20px rgba(0,0,0,.25);
    cursor:pointer;
}

/* INPUT */
.form-control{
    border-radius:10px;
    font-size:14px;
}

/* DOCS */
.doc-img{
    width:180px;
    height:180px;
    object-fit:contain;
    background:#fff;
    padding:12px;
    border-radius:16px;
    box-shadow:0 10px 25px rgba(0,0,0,.2);
    transition:.3s;
    cursor:pointer;
}
.doc-img:hover{transform:scale(1.06)}

/* IMAGE MODAL */
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
}
.close-btn{
    position:absolute;
    top:20px;
    right:30px;
    font-size:34px;
    color:#fff;
    cursor:pointer;
}
</style>
</head>

<body>

<%
Users user = (Users) request.getAttribute("user");
if(user == null){
    response.sendRedirect("admin-Dashboard");
    return;
}
%>

<!-- SIDEBAR -->
<div class="sidebar">
    <i class="fa fa-university fa-3x mb-3"></i>
    <h4>Aashray-UniTrust Bank</h4>
    <p>Admin Verification Desk</p>
    <hr>
    </div>

<!-- MAIN -->
<div class="main">
<div class="card-ui">

<!-- HEADER -->
<div class="row align-items-center mb-4">
    <div class="col-md-3 text-center">
        <img src="<%=request.getContextPath()%>/users/<%=user.getPhoto()%>" class="profile-img zoom-img">
        <h6 class="mt-3 mb-0 fw-bold">
            <%=user.getFname()%> <%=user.getLname()%>
        </h6>
        <small class="text-muted">Customer Photo</small>
    </div>
    <div class="col-md-9">
        <h4 class="fw-bold text-primary">Account Opening Verification</h4>
        <small class="text-muted">Read-only submitted customer information</small>
    </div>
</div>

<span class="section-title">Personal Details</span>
<div class="row">
    <div class="col-md-4 mb-3"><input class="form-control" value="<%=user.getFname()%>" readonly></div>
    <div class="col-md-4 mb-3"><input class="form-control" value="<%=user.getLname()%>" readonly></div>
    <div class="col-md-4 mb-3"><input class="form-control" value="<%=user.getDob()%>" readonly></div>
</div>

<span class="section-title">Contact Details</span>
<div class="row">
    <div class="col-md-4 mb-3"><input class="form-control" value="<%=user.getPhone()%>" readonly></div>
    <div class="col-md-4 mb-3"><input class="form-control" value="<%=user.getEmail()%>" readonly></div>
    <div class="col-md-4 mb-3"><input class="form-control" value="<%=user.getPincode()%>" readonly></div>
</div>

<textarea class="form-control mb-3" readonly>
<%=user.getAddress()%>, <%=user.getCity()%>, <%=user.getState()%>
</textarea>

<span class="section-title">Documents</span>
<div class="row text-center">
    <div class="col-md-4 mb-4">
        <img src="<%=request.getContextPath()%>/Signature/<%=user.getSignature()%>" class="doc-img zoom-img">
        <p class="fw-bold small mt-2">Signature</p>
    </div>
    <div class="col-md-4 mb-4">
        <img src="<%=request.getContextPath()%>/Aadhar/<%=user.getAadhardoc()%>" class="doc-img zoom-img">
        <p class="fw-bold small mt-2">Aadhar</p>
    </div>
    <div class="col-md-4 mb-4">
        <img src="<%=request.getContextPath()%>/PAN/<%=user.getPandoc()%>" class="doc-img zoom-img">
        <p class="fw-bold small mt-2">PAN</p>
    </div>
</div>

<div class="text-end">
    <a href="admin-Dashboard" class="btn btn-dark px-4">
        ⬅ Back to Dashboard
    </a>
</div>

</div>
</div>

<!-- IMAGE MODAL -->
<div class="img-modal" id="imgModal">
    <span class="close-btn" onclick="closeImg()">×</span>
    <img id="modalImg">
</div>

<script>
const modal=document.getElementById("imgModal");
const modalImg=document.getElementById("modalImg");

document.querySelectorAll(".zoom-img").forEach(img=>{
    img.onclick=()=>{
        modal.style.display="flex";
        modalImg.src=img.src;
    }
});
function closeImg(){modal.style.display="none";}
modal.onclick=e=>{if(e.target===modal)closeImg();}
</script>

</body>
</html>
