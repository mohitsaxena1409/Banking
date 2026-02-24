
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Login | Aashray-UniTrust Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-hover:#03316E;
    --brand-light:#E7EEFA;
}

/* ===== BODY ===== */
body{
    background:
      linear-gradient(rgba(1,26,65,0.6), rgba(1,26,65,0.6)),
      url("img/carousel-1.jpg");
    background-size:cover;
    background-position:center;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'Segoe UI', sans-serif;
}

/* ===== CARD ===== */
.login-card{
    background:#fff;
    border-radius:15px;
    padding:35px;
    max-width:420px;
    width:100%;
    box-shadow:0 15px 40px rgba(0,0,0,0.25);
    animation:fadeIn 0.6s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(12px);}
    to{opacity:1; transform:translateY(0);}
}

/* ===== TITLE ===== */
.bank-title{
    color:var(--brand);
    font-weight:700;
}

/* ===== INPUT ===== */
.form-control{
    border-radius:8px;
}

.form-control:focus{
    border-color:var(--brand);
    box-shadow:0 0 0 0.12rem rgba(1,26,65,0.25);
}

/* ===== CAPTCHA ===== */
.captcha-box{
    background:var(--brand-light);
    color:var(--brand);
    font-weight:bold;
    letter-spacing:4px;
    padding:12px;
    text-align:center;
    border-radius:8px;
    user-select:none;
}

/* ===== BUTTON ===== */
.btn-primary{
    background:var(--brand);
    border:none;
    border-radius:8px;
    font-weight:600;
}

.btn-primary:hover{
    background:var(--brand-hover);
    box-shadow:0 6px 14px rgba(1,26,65,0.35);
}

/* ===== LINK ===== */
a.text-primary{
    color:var(--brand) !important;
}

a.text-primary:hover{
    color:var(--brand-hover) !important;
}
</style>
</head>

<body>

<%
String username=(String)session.getAttribute("username");
String role=(String)session.getAttribute("role");

%>

<%
String chars="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcddefghijklmnopqrstuvwxyz";
StringBuilder captcha=new StringBuilder();
for(int i=0;i<6;i++){
    int index=(int)(Math.random()*chars.length());
    captcha.append(chars.charAt(index));
}
session.setAttribute("captcha",captcha.toString());
%>

<div class="login-card">

<div class="text-center mb-4">
    <i class="fa fa-university fa-3x mb-2" style="color:#011A41"></i>
    <h3 class="bank-title">Aashray-UniTrust Bank</h3>
    <p class="text-muted">Secure Login</p>
</div>
<%
String msg = (String) request.getAttribute("msg");
if (msg != null) {

    boolean success =
        msg.equalsIgnoreCase("Registration successfull ! Await for admin approval.")
        || msg.equalsIgnoreCase("Details Updated Successfully");
%>

<div class="alert <%= success ? "alert-success" : "alert-danger" %> text-center">
    <%= msg %>
</div>

<% } %>


<form action="checkUser" method="post">

<div class="form-floating mb-3">
    <input type="text" name="username" class="form-control" placeholder="Username" required>
    <label>Username</label>
</div>

<div class="form-floating mb-3">
    <input type="password" name="password" class="form-control" placeholder="Password" required>
    <label>Password</label>
</div>

<div class="mb-3">
    <div class="captcha-box mb-2">
        <%=captcha.toString()%>
    </div>
    <input type="text" name="captchaInput" class="form-control" placeholder="Enter Captcha" required>
</div>

<button class="btn btn-primary w-100 py-2">
    Sign In
</button>

</form>

<div class="text-center mt-3">
<small class="text-muted">
    Don't have an account?
    <a href="signUp" class="fw-bold">Sign Up</a>
</small>
</div>

</div>

</body>
</html>
