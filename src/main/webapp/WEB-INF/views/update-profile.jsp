<%@ page import="com.bank.pojo.Users"%>
<%
Users u = (Users) session.getAttribute("loggedUser");
if (u == null) {
    response.sendRedirect("index");
    return;
}

String msg = (String) request.getAttribute("msg");
String err = (String) request.getAttribute("err");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/titleLogo.png" type="image/png">
<title>Update Profile | Aashray-UniTrust Bank</title>
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
@keyframes fadeIn{
    from{opacity:0; transform:translateY(12px);}
    to{opacity:1; transform:translateY(0);}
}
.login-card{
    ...
    animation:fadeIn 0.6s ease;
}
animation: fadeIn 0.6s ease;


</style>
</head>

<body>
<div class="login-card">


    <div class="text-center mb-4">
        <i class="fa fa-user-edit fa-3x mb-2" style="color:#011A41"></i>
        <h3 class="bank-title">Update Profile</h3>
        <p class="text-muted">Secure Account Update</p>
    </div>

    <% if (msg != null) { %>
        <div class="alert alert-success text-center">
            <%= msg %>
        </div>
    <% } %>

    <% if (err != null) { %>
        <div class="alert alert-danger text-center">
            <%= err %>
        </div>
    <% } %>

    <form action="send-update-otp" method="post">

        <div class="form-floating mb-3">
            <input type="text"
                   name="username"
                   value="<%=u.getUsername()%>"
                   class="form-control"
                   placeholder="Username"
                   required>
            <label>Username</label>
        </div>

        <div class="form-floating mb-3">
            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="New Password"
                   required>
            <label>New Password</label>
        </div>

        <button class="btn btn-primary w-100 py-2">
            Send OTP
        </button>

    </form>

</div>

</body>
</html>
