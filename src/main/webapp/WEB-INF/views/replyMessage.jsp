<%@ page import="com.bank.pojo.ContactMessage" %>
<%
ContactMessage m = (ContactMessage) request.getAttribute("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Reply Message | Admin Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{ --brand:#011A41; }

body{
    background:
      linear-gradient(rgba(1,26,65,0.65), rgba(1,26,65,0.65)),
      url("img/carousel-1.jpg");
    background-size:cover;
    background-position:center;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}

/* animation */
@keyframes fadeIn{
    from{ opacity:0; transform:translateY(15px); }
    to{ opacity:1; transform:translateY(0); }
}

.page-wrapper{
    animation:fadeIn .6s ease;
}

.header{
    background:var(--brand);
    color:#fff;
    padding:20px;
    border-radius:16px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,.25);
    margin-bottom:25px;
}

.card-ui{
    background:#fff;
    border-radius:18px;
    box-shadow:0 15px 35px rgba(0,0,0,.2);
    padding:25px;
}

.info-box{
    background:#f8f9fa;
    border-left:5px solid var(--brand);
    padding:15px;
    border-radius:12px;
}

textarea{
    resize:none;
}

.suggest button{
    margin:5px 5px 0 0;
}
</style>

<script>
function setReply(text){
    document.getElementById("reply").value = text;
}
</script>
</head>

<body>

<div class="container py-4 page-wrapper">

<!-- HEADER -->
<div class="header">
<i class="fa fa-reply fa-2x mb-2"></i>
<h4 class="mb-0">Customer Message Reply</h4>
<small>Admin Panel | Aashray-UniTrust Bank</small>
</div>

<!-- CARD -->
<div class="card-ui">

<h5 class="fw-bold mb-3">
<i class="fa fa-envelope-open-text me-2"></i>Customer Query Details
</h5>

<div class="info-box mb-4">
<p><b>Name:</b> <%= m.getName() %></p>
<p><b>Email:</b> <%= m.getEmail() %></p>
<p><b>Subject:</b> <%= m.getSubject() %></p>
<p class="mb-0"><b>Message:</b> <%= m.getMessage() %></p>
</div>

<form action="sendReply" method="post">
<input type="hidden" name="id" value="<%= m.getId() %>">
<input type="hidden" name="email" value="<%= m.getEmail() %>">

<div class="mb-3">
<label class="form-label fw-semibold">
<i class="fa fa-pen me-1"></i>Official Reply
</label>
<textarea id="reply" name="replyText" class="form-control" rows="5"
placeholder="Type official bank reply here..." required></textarea>
</div>

<div class="mb-3">
<label class="fw-semibold d-block mb-2">
<i class="fa fa-lightbulb me-1"></i>Quick Reply Templates
</label>

<!-- General -->
<button type="button" class="btn btn-sm btn-outline-primary"
 onclick="setReply('Thank you for contacting Aashray-UniTrust Bank. We have received your query and our support team will assist you shortly.')">
General Acknowledgement
</button>

<button type="button" class="btn btn-sm btn-outline-primary"
 onclick="setReply('Your concern is important to us. We are currently reviewing your request and will update you within 24 hours.')">
Under Review
</button>

<!-- Account -->
<button type="button" class="btn btn-sm btn-outline-success"
 onclick="setReply('Your bank account details have been verified successfully. You can now access all available banking services.')">
Account Verified
</button>

<button type="button" class="btn btn-sm btn-outline-success"
 onclick="setReply('Please ensure your KYC documents are complete to activate all account features.')">
KYC Required
</button>

<!-- Transaction -->
<button type="button" class="btn btn-sm btn-outline-warning"
 onclick="setReply('We are checking the reported transaction issue. Kindly allow us some time to investigate the same.')">
Transaction Issue
</button>

<button type="button" class="btn btn-sm btn-outline-warning"
 onclick="setReply('The transaction is currently pending due to banking verification. It will be resolved shortly.')">
Transaction Pending
</button>


<!-- Support -->
<button type="button" class="btn btn-sm btn-outline-secondary"
 onclick="setReply('We request you to visit the nearest Aashray-UniTrust Bank branch with valid documents for further assistance.')">
Visit Branch
</button>

<button type="button" class="btn btn-sm btn-outline-secondary"
 onclick="setReply('For security reasons, certain actions require in-person verification at our branch.')">
Security Verification
</button>

</div>


<div class="text-center mt-4">
<button type="submit" class="btn px-4 text-white"
style="background:var(--brand);">
<i class="fa fa-paper-plane me-1"></i> Send Reply
</button>
</div>

</form>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
