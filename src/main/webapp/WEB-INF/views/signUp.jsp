<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
<title>Account Registration | Aashray-UniTrust Bank</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
:root{
    --brand:#011A41;
    --brand-hover:#03316E;
    --brand-light:#E7EEFA;
    --success:#198754;
}
body{
    background:linear-gradient(rgba(1,26,65,.65),rgba(1,26,65,.65)),
    url("img/carousel-1.jpg");
    background-size:cover;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}
.form-card{
    background:#fff;
    border-radius:18px;
    padding:40px;
    max-width:920px;
    margin:40px auto;
    box-shadow:0 18px 45px rgba(0,0,0,.3);
}
.bank-title{color:var(--brand);font-weight:700}
.step{display:none}
.step.active{display:block}

.section-box{
    background:#f9fbff;
    border:1px solid #e1e8f5;
    border-radius:14px;
    padding:25px;
    margin-bottom:20px;
}

.form-control,.form-select{
    border-radius:10px;
    padding:10px 12px;
}
.form-control:focus,.form-select:focus{
    border-color:var(--brand);
    box-shadow:0 0 0 .12rem rgba(1,26,65,.25)
}

.btn{
    padding:10px 22px;
    font-weight:600;
    border-radius:10px;
}
.btn-primary{background:var(--brand);border:none}
.btn-primary:hover{background:var(--brand-hover)}
.btn-success{
    background:var(--success);
    border:none;
    font-size:17px;
}
.btn-success:hover{opacity:.9}

.action-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-top:25px;
}

.progress{
    height:9px;
    border-radius:10px;
}
.progress-bar{background:var(--brand)}

.fade-msg{
    animation:fade .4s;
    border-radius:12px;
    font-weight:600;
}
@keyframes fade{from{opacity:0}to{opacity:1}}

.doc-hint{
    font-size:13px;
    color:#6c757d;
}
</style>
</head>

<body>

<div class="form-card">

<div class="text-center mb-3">
    <i class="fa fa-university fa-3x mb-2 text-primary"></i>
    <h4 class="bank-title">Aashray-UniTrust Bank</h4>
    <p class="text-muted">Account Opening Form</p>
</div>

<div id="pageMsg" class="alert d-none text-center fade-msg"></div>

<div class="progress mb-3">
  <div class="progress-bar" id="progressBar" style="width:20%"></div>
</div>
<p class="text-center text-muted">Step <span id="stepNo">1</span> of 5</p>

<form action="signUp" method="post" enctype="multipart/form-data">

<!-- STEP 1 -->
<div class="step active">
<div class="section-box">
<h5 class="bank-title">Personal Details</h5><hr>
<div class="row">
    <div class="col-md-6 mb-3"><input name="fname" class="form-control" placeholder="First Name" required></div>
    <div class="col-md-6 mb-3"><input name="lname" class="form-control" placeholder="Last Name" required></div>
    <div class="col-md-6 mb-3"><input type="date" name="dob" class="form-control" required></div>
    <div class="col-md-6 mb-3">
        <select name="gender" class="form-select" required>
            <option value="">Gender</option>
            <option>Male</option><option>Female</option><option>Other</option>
        </select>
    </div>
</div>

<div class="action-bar">
    <div></div>
    <button type="button" class="btn btn-primary next">
        Next <i class="fa fa-arrow-right ms-1"></i>
    </button>
</div>
</div>
</div>

<!-- STEP 2 -->
<div class="step">
<div class="section-box">
<h5 class="bank-title">Contact & Email Verification</h5><hr>

<input name="phone" class="form-control mb-3" placeholder="Mobile Number" required>
<input name="email" class="form-control mb-3" placeholder="Email Address" required>

<button type="button" id="sendOtpBtn" class="btn btn-primary w-100 mb-3" onclick="sendOtp()">
<i class="fa fa-paper-plane me-1"></i> Send OTP
</button>

<div id="otpBlock" style="display:none">
    <input name="otp" class="form-control mb-3" placeholder="Enter OTP">
    <button type="button" class="btn btn-success w-100 mb-3" onclick="verifyOtp()">
        <i class="fa fa-check-circle me-1"></i> Verify OTP
    </button>
</div>

<textarea name="address" class="form-control mb-3" placeholder="Full Address" readonly required></textarea>

<div class="row">
    <div class="col-md-4 mb-3"><input name="city" class="form-control" placeholder="City" readonly required></div>
    <div class="col-md-4 mb-3"><input name="state" class="form-control" placeholder="State" readonly required></div>
    <div class="col-md-4 mb-3"><input name="pincode" class="form-control" placeholder="Pincode" readonly required></div>
</div>

<div class="action-bar">
    <button type="button" class="btn btn-secondary prev">
        <i class="fa fa-arrow-left me-1"></i> Back
    </button>
    <button type="button" class="btn btn-primary next" id="step2Next" disabled>
        Next <i class="fa fa-arrow-right ms-1"></i>
    </button>
</div>
</div>
</div>

<!-- STEP 3 -->
<div class="step">
<div class="section-box">
<h5 class="bank-title">KYC Details</h5><hr>
<input name="aadharno" class="form-control mb-3" placeholder="Aadhaar Number" required>
<input name="panno" class="form-control mb-3" placeholder="PAN Number" required>

<div class="action-bar">
    <button type="button" class="btn btn-secondary prev">
        <i class="fa fa-arrow-left me-1"></i> Back
    </button>
    <button type="button" class="btn btn-primary next">
        Next <i class="fa fa-arrow-right ms-1"></i>
    </button>
</div>
</div>
</div>

<!-- STEP 4 -->
<div class="step">
<div class="section-box">
<h5 class="bank-title">Upload Documents</h5><hr>

<label class="fw-bold">Passport Size Photo</label>
<div class="doc-hint mb-1">Recent photo, white background</div>
<input type="file" name="photo" class="form-control mb-3" required>

<label class="fw-bold">Signature</label>
<div class="doc-hint mb-1">Sign on white paper</div>
<input type="file" name="signature" class="form-control mb-3" required>

<label class="fw-bold">Aadhaar Card</label>
<div class="doc-hint mb-1">Front side clear image / PDF</div>
<input type="file" name="aadhardoc" class="form-control mb-3" required>

<label class="fw-bold">PAN Card</label>
<div class="doc-hint mb-1">Clear image / PDF</div>
<input type="file" name="pandoc" class="form-control mb-3" required>

<div class="action-bar">
    <button type="button" class="btn btn-secondary prev">
        <i class="fa fa-arrow-left me-1"></i> Back
    </button>
    <button type="button" class="btn btn-primary next">
        Next <i class="fa fa-arrow-right ms-1"></i>
    </button>
</div>
</div>
</div>

<!-- STEP 5 -->
<div class="step">
<div class="section-box">
<h5 class="bank-title">Account Preferences</h5><hr>

<select name="accounttype" class="form-select mb-3" required>
    <option value="">Account Type</option>
    <option>SAVINGS</option>
    <option>CURRENT</option>
</select>

<select name="modeofoperation" class="form-select mb-3" required>
    <option value="">Mode of Operation</option>
    <option>SINGLE</option>
    <option>JOINT</option>
</select>

<select name="atmfacility" class="form-select mb-3">
    <option value="1">ATM Card Required</option>
    <option value="0">ATM Card Not Required</option>
</select>

<select name="chequebook" class="form-select mb-3">
    <option value="1">Cheque Book Required</option>
    <option value="0">Cheque Book Not Required</option>
</select>

<div class="action-bar">
    <button type="button" class="btn btn-secondary prev">
        <i class="fa fa-arrow-left me-1"></i> Back
    </button>
    <button type="submit" class="btn btn-success px-5 shadow">
        <i class="fa fa-check-circle me-2"></i>
        Submit for Approval
    </button>
</div>
</div>
</div>

</form>
</div>

<script>
let current=0;
const steps=document.querySelectorAll(".step");
const bar=document.getElementById("progressBar");
const stepNo=document.getElementById("stepNo");

function updateUI(){
    bar.style.width=((current+1)/steps.length*100)+"%";
    stepNo.innerText=current+1;
}
document.querySelectorAll(".next").forEach(b=>b.onclick=()=>{
    steps[current].classList.remove("active");
    current++;steps[current].classList.add("active");updateUI();
});
document.querySelectorAll(".prev").forEach(b=>b.onclick=()=>{
    steps[current].classList.remove("active");
    current--;steps[current].classList.add("active");updateUI();
});

function showMsg(text,type){
    const box=document.getElementById("pageMsg");
    box.className="alert alert-"+type+" text-center fade-msg";
    box.innerText=text;
    box.classList.remove("d-none");
    setTimeout(()=>box.classList.add("d-none"),4000);
}

function sendOtp(){
    const email=document.querySelector('[name=email]').value;
    if(!email){showMsg("Enter email first","danger");return;}
    const btn=document.getElementById("sendOtpBtn");
    btn.innerHTML='<i class="fa fa-spinner fa-spin"></i> Sending OTP...';
    btn.disabled=true;
    fetch("sendSignupOtp",{method:"POST",headers:{"Content-Type":"application/x-www-form-urlencoded"},
    body:"email="+encodeURIComponent(email)})
    .then(()=>{btn.style.display="none";document.getElementById("otpBlock").style.display="block";
    showMsg("OTP sent to email","info");});
}

function verifyOtp(){
    const otp=document.querySelector('[name=otp]').value;
    fetch("verifySignupOtp",{method:"POST",headers:{"Content-Type":"application/x-www-form-urlencoded"},
    body:"otp="+encodeURIComponent(otp)})
    .then(r=>r.text()).then(res=>{
        if(res==="SUCCESS"){
            document.querySelectorAll('[name=address],[name=city],[name=state],[name=pincode]')
            .forEach(e=>e.readOnly=false);
            document.getElementById("otpBlock").style.display="none";
            document.getElementById("step2Next").disabled=false;
            showMsg("Email verified successfully","success");
        }else showMsg("Invalid / Expired OTP","danger");
    });
}
</script>

</body>
</html>
