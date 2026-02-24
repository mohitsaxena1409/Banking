<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bank.pojo.Users"%>

<%
Users admin = (Users) session.getAttribute("loggedUser");
if(admin == null){
    response.sendRedirect("signIn");
    return;
}

Users u = (Users) request.getAttribute("user");
if(u == null){
    response.sendRedirect("updateUsers");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
    <title>Aashray-UniTrust Bank</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{ --brand:#011A41; }
body{
    background:#f5f6fa;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}
.card-ui{
    background:#fff;
    border-radius:18px;
    padding:25px;
    box-shadow:0 10px 20px rgba(0,0,0,.15);
}
.section-title{
    font-weight:700;
    color:var(--brand);
}
.form-control{
    border-radius:12px;
}
</style>
</head>

<body>

<div class="container py-4">

<div class="card-ui mb-4 text-center">
<i class="fa fa-user-edit fa-3x text-warning mb-2"></i>
<h4 class="section-title mb-0">Update User Details</h4>
<small>Only Personal & Address details</small>
</div>

<div class="card-ui col-lg-9 mx-auto">

<form action="<%=request.getContextPath()%>/updateUser" method="post">

<input type="hidden" name="id" value="<%=u.getId()%>">

<h5 class="section-title mb-3">
<i class="fa fa-id-card me-2"></i>Personal Details
</h5>

<div class="row g-3">
<div class="col-md-6">
<label>First Name</label>
<input class="form-control" name="fname" value="<%=u.getFname()%>" required>
</div>

<div class="col-md-6">
<label>Last Name</label>
<input class="form-control" name="lname" value="<%=u.getLname()%>" required>
</div>

<div class="col-md-6">
<label>Date of Birth</label>
<input type="date" class="form-control" name="dob" value="<%=u.getDob()%>">
</div>

<div class="col-md-6">
<label>Gender</label>
<select name="gender" class="form-control">
<option <%= "Male".equals(u.getGender())?"selected":"" %>>Male</option>
<option <%= "Female".equals(u.getGender())?"selected":"" %>>Female</option>
<option <%= "Other".equals(u.getGender())?"selected":"" %>>Other</option>
</select>
</div>

<div class="col-md-6">
<label>Phone</label>
<input class="form-control" name="phone" value="<%=u.getPhone()%>" required>
</div>

<div class="col-md-6">
<label>Email</label>
<input class="form-control" value="<%=u.getEmail()%>" disabled>
</div>
</div>

<hr>

<h5 class="section-title mb-3">
<i class="fa fa-map-marker-alt me-2"></i>Address Details
</h5>

<div class="row g-3">
<div class="col-12">
<label>Address</label>
<textarea name="address" class="form-control" rows="2"><%=u.getAddress()%></textarea>
</div>

<div class="col-md-4">
<label>City</label>
<input class="form-control" name="city" value="<%=u.getCity()%>">
</div>

<div class="col-md-4">
<label>State</label>
<input class="form-control" name="state" value="<%=u.getState()%>">
</div>

<div class="col-md-4">
<label>Pincode</label>
<input class="form-control" name="pincode" value="<%=u.getPincode()%>">
</div>
</div>

<div class="d-flex gap-2 mt-4">
<button class="btn btn-dark w-50">
<i class="fa fa-save me-1"></i> Update User
</button>

<a href="<%=request.getContextPath()%>/updateUsers" class="btn btn-outline-dark w-50">
<i class="fa fa-arrow-left me-1"></i> Back
</a>
</div>

</form>
</div>
</div>

</body>
</html>
