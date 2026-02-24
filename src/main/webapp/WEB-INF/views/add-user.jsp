
<%
String username= (String)session.getAttribute("username");
if(username==null)
{
	response.sendRedirect("signIn");
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Add New User | Admin Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-light:#F2F6FF;
}

body{
    background:#f4f6f9;
    font-family:'Segoe UI', sans-serif;
}

.admin-wrapper{
    max-width:1250px;
    margin:25px auto;
}

.form-card{
    background:#fff;
    border-radius:10px;
    box-shadow:0 12px 35px rgba(0,0,0,.08);
    padding:30px;
}

.bank-header{
    border-bottom:2px solid var(--brand-light);
    margin-bottom:25px;
    padding-bottom:10px;
}

.bank-title{
    color:var(--brand);
    font-weight:700;
}

.section-box{
    background:var(--brand-light);
    border-radius:8px;
    padding:22px;
    margin-bottom:25px;
}

.section-title{
    font-weight:600;
    color:var(--brand);
    margin-bottom:18px;
    font-size:15px;
}

.form-control, .form-select{
    border-radius:6px;
    font-size:14px;
}

.form-control:focus, .form-select:focus{
    border-color:var(--brand);
    box-shadow:0 0 0 .15rem rgba(1,26,65,.25);
}

label{
    font-weight:600;
    font-size:13px;
    color:#011A41;
}

.btn-brand{
    background:var(--brand);
    color:#fff;
    font-weight:600;
}
.btn-brand:hover{ background:#03316E; }

.alert-success{
    background:#e8f0ff;
    color:#011A41;
    border-left:5px solid #011A41;
}
.alert-danger{
    background:#fdeaea;
    color:#9b1c1c;
    border-left:5px solid #9b1c1c;
}

.info-box{
    background:#fff;
    border-left:5px solid var(--brand);
    padding:12px 15px;
    border-radius:6px;
    font-size:13px;
}
</style>
</head>

<body>

<div class="admin-wrapper">
<div class="form-card">

<!-- HEADER -->
<div class="bank-header d-flex justify-content-between align-items-center">
    <div>
        <h5 class="bank-title mb-0">
            <i class="fa fa-user-plus me-2"></i>Add New Bank User
        </h5>
        <small class="text-muted">Admin Panel – User Creation</small>
    </div>
    <a href="admin-Dashboard" class="btn btn-sm btn-brand">
        <i class="fa fa-arrow-left"></i> Back
    </a>
</div>

<!-- MESSAGE -->
<%
String msg = (String) request.getAttribute("msg");

if (msg != null) {
    boolean isSuccess =
        msg.equalsIgnoreCase("User Added Successfully! Please Approve User....");
%>
<div class="alert <%= isSuccess ? "alert-success" : "alert-danger" %> alert-dismissible fade show">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    session.removeAttribute("msg");
}
%>

<form action="addUser" method="post" enctype="multipart/form-data">

<!-- PERSONAL DETAILS -->
<div class="section-box">
<div class="section-title"><i class="fa fa-id-card me-2"></i>Personal Details</div>
<div class="row">
    <div class="col-md-4 mb-3">
        <label>First Name</label>
        <input type="text" name="fname" class="form-control" required>
    </div>
    <div class="col-md-4 mb-3">
        <label>Last Name</label>
        <input type="text" name="lname" class="form-control" required>
    </div>
    <div class="col-md-4 mb-3">
        <label>Date of Birth</label>
        <input type="date" name="dob" class="form-control" required>
    </div>
    <div class="col-md-4 mb-3">
        <label>Gender</label>
        <select name="gender" class="form-select" required>
            <option value="">Select</option>
            <option>Male</option>
            <option>Female</option>
            <option>Other</option>
        </select>
    </div>
</div>
</div>

<!-- CONTACT -->
<div class="section-box">
<div class="section-title"><i class="fa fa-map-marker-alt me-2"></i>Contact & Address</div>
<div class="row">
    <div class="col-md-4 mb-3">
        <label>Phone Number</label>
        <input type="text" name="phone" class="form-control" required>
    </div>
    <div class="col-md-4 mb-3">
        <label>Email Address</label>
        <input type="email" name="email" class="form-control" required>
    </div>
    <div class="col-md-12 mb-3">
        <label>Full Address</label>
        <textarea name="address" class="form-control" required></textarea>
    </div>
    <div class="col-md-4 mb-3">
        <label>City</label>
        <input type="text" name="city" class="form-control" required>
    </div>
    <div class="col-md-4 mb-3">
        <label>State</label>
        <input type="text" name="state" class="form-control" required>
    </div>
    <div class="col-md-4 mb-3">
        <label>Pincode</label>
        <input type="text" name="pincode" class="form-control" required>
    </div>
</div>
</div>

<!-- KYC -->
<div class="section-box">
<div class="section-title"><i class="fa fa-shield-alt me-2"></i>KYC Details</div>
<div class="row">
    <div class="col-md-6 mb-3">
        <label>Aadhaar Number</label>
        <input type="text" name="aadharno" class="form-control" required>
    </div>
    <div class="col-md-6 mb-3">
        <label>PAN Number</label>
        <input type="text" name="panno" class="form-control" required>
    </div>
</div>
</div>

<!-- DOCUMENTS -->
<div class="section-box">
<div class="section-title">
    <i class="fa fa-upload me-2"></i>Documents Upload
    <span class="badge ms-2" style="background:#011A41;">Mandatory</span>
</div>

<div class="row">
    <div class="col-md-6 mb-3">
        <label>Passport Size Photo</label>
        <input type="file" name="photo" class="form-control" required>
        <small class="text-muted">Clear recent photograph (JPG/PNG)</small>
    </div>
    <div class="col-md-6 mb-3">
        <label>Signature Image</label>
        <input type="file" name="signature" class="form-control" required>
        <small class="text-muted">Customer handwritten signature</small>
    </div>
    <div class="col-md-6 mb-3">
        <label>Aadhaar Card</label>
        <input type="file" name="aadhardoc" class="form-control" required>
        <small class="text-muted">Government issued Aadhaar</small>
    </div>
    <div class="col-md-6 mb-3">
        <label>PAN Card</label>
        <input type="file" name="pandoc" class="form-control" required>
        <small class="text-muted">Income Tax PAN</small>
    </div>
</div>

<div class="info-box mt-3">
    <i class="fa fa-info-circle me-2"></i>
    Ensure all documents are readable and belong to the customer.
</div>
</div>

<!-- ACCOUNT -->
<div class="section-box">
<div class="section-title"><i class="fa fa-university me-2"></i>Account Setup</div>
<div class="row">
    <div class="col-md-3 mb-3">
        <label>Account Type</label>
        <select name="accounttype" class="form-select" required>
            <option value="">Select</option>
            <option>SAVINGS</option>
            <option>CURRENT</option>
        </select>
    </div>
    <div class="col-md-3 mb-3">
        <label>Mode of Operation</label>
        <select name="modeofoperation" class="form-select" required>
            <option value="">Select</option>
            <option>SINGLE</option>
            <option>JOINT</option>
        </select>
    </div>
    <div class="col-md-3 mb-3">
        <label>ATM Facility</label>
        <select name="atmfacility" class="form-select">
            <option value="1">Required</option>
            <option value="0">Not Required</option>
        </select>
    </div>
    <div class="col-md-3 mb-3">
        <label>Cheque Book</label>
        <select name="chequebook" class="form-select">
            <option value="1">Required</option>
            <option value="0">Not Required</option>
        </select>
    </div>
</div>
</div>

<div class="text-end">
    <input type="submit" class="btn btn-success px-4" value="Create User">

</div>

</form>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
