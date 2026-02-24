<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/titleLogo.png" type="image/png">
<title>Verify OTP | Aashray-UniTrust Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-hover:#03316E;
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

/* ===== MESSAGE POPUP ===== */
.msg-popup{
    position:fixed;
    top:20px;
    left:50%;
    transform:translateX(-50%);
    z-index:9999;
    min-width:300px;
    max-width:90%;
    padding:14px 20px;
    border-radius:10px;
    font-weight:600;
    text-align:center;
    animation:slideDown .4s ease;
}

.msg-success{
    background:#198754;
    color:#fff;
}

.msg-error{
    background:#dc3545;
    color:#fff;
}

@keyframes slideDown{
    from{opacity:0; transform:translate(-50%,-20px);}
    to{opacity:1; transform:translate(-50%,0);}
}

/* ===== CARD ===== */
.login-card{
    background:#fff;
    border-radius:15px;
    padding:35px;
    max-width:400px;
    width:100%;
    box-shadow:0 15px 40px rgba(0,0,0,0.25);
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

/* ===== BUTTON ===== */
.btn-success{
    background:var(--brand);
    border:none;
    border-radius:8px;
    font-weight:600;
}

.btn-success:hover{
    background:var(--brand-hover);
}

.msg-popup{
    padding:12px 18px;
    border-radius:10px;
    margin:10px 0;
    font-weight:500;
}

.msg-theme{
    background:#011A41;   /* aapki theme blue */
    color:#fff;
}

.msg-error{
    background:#dc3545;   /* red */
    color:#fff;
}

</style>
</head>

<body>

<!-- ✅ MESSAGE SHOW AREA -->
<!-- ✅ MESSAGE SHOW AREA -->
<%
String msg = (String) request.getAttribute("msg");
if(msg != null){
    boolean isError = msg.equalsIgnoreCase("Username already exists");
%>
<div class="msg-popup <%= isError ? "msg-error" : "msg-theme" %>">
    <i class="fa <%= isError ? "fa-times-circle" : "fa-check-circle" %> me-1"></i>
    <%= msg %>
</div>
<% } %>


<div class="login-card">

    <div class="text-center mb-4">
        <i class="fa fa-shield-alt fa-3x mb-2" style="color:#011A41"></i>
        <h4 class="bank-title">OTP Verification</h4>
        <p class="text-muted">Secure Update Confirmation</p>
    </div>

    <form action="verify-update-otp" method="post">

        <div class="form-floating mb-3">
            <input type="text"
                   name="otp"
                   class="form-control"
                   placeholder="Enter OTP"
                   required>
            <label>Enter OTP</label>
        </div>

        <button class="btn btn-success w-100 py-2">
            Verify & Update
        </button>

    </form>

</div>

<script>
/* auto hide msg after 4 sec */
setTimeout(()=>{
    let msg=document.querySelector('.msg-popup');
    if(msg) msg.style.display='none';
},4000);
</script>

</body>
</html>
