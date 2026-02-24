<style>
:root{
    --brand:#011A41;
}
.callback{
    background:linear-gradient(135deg,#011A41,#022b6f);
}
.callback-card{
    border-radius:18px;
    box-shadow:0 15px 35px rgba(0,0,0,.25);
}
.form-control{
    border-radius:12px;
}
.btn-brand{
    background:var(--brand);
    border:none;
}
.btn-brand:hover{
    background:#022b6f;
}
.alert-blocked{
    background:#ffe6e6;
    border-left:6px solid #dc3545;
    color:#842029;
    font-weight:500;
    border-radius:10px;
}
</style>

<!-- Callback Start -->
<div class="container-fluid callback py-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-7">

                <div class="bg-white callback-card p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.5s">

                    <div class="text-center mb-4">
                        <span class="badge bg-light text-primary px-3 py-2 rounded-pill mb-3">
                            Get In Touch
                        </span>
                        <h1 class="display-6 fw-bold text-dark">
                            Contact us
                        </h1>
                        
                    </div>

                   <%
						String msg = (String) request.getAttribute("msg");
						if (msg != null) {
						
						    boolean blocked =
						        msg.equals("You are blocked Kindly send an Request for Activation");
						%>
						
						<div class="alert <%= blocked ? "alert-danger" : "alert-success" %> text-center mb-4">
						    <i class="fa <%= blocked ? "fa-ban" : "fa-check-circle" %> me-2"></i>
						    <%= msg %>
						</div>
						
					<% } %>


                    <form action="sendMessage" method="post">

<div class="row g-3">
    <div class="col-sm-6">
        <div class="form-floating">
            <input type="text" class="form-control" name="name" placeholder="Your Name" required>
            <label>Your Name</label>
        </div>
    </div>

    <div class="col-sm-6">
        <div class="form-floating">
            <input type="email" class="form-control" name="email" placeholder="Your Email" required>
            <label>Your Email</label>
        </div>
    </div>

    <div class="col-sm-6">
        <div class="form-floating">
            <input type="text" class="form-control" name="mobile" placeholder="Your Mobile" required>
            <label>Your Mobile</label>
        </div>
    </div>

    <div class="col-sm-6">
        <div class="form-floating">
            <input type="text" class="form-control" name="subject" placeholder="Subject" required>
            <label>Subject</label>
        </div>
    </div>

    <div class="col-12">
        <div class="form-floating">
            <textarea class="form-control" name="message"
                style="height:120px" placeholder="Leave a message" required></textarea>
            <label>Message</label>
        </div>
    </div>

    <div class="col-12 text-center mt-3">
        <button type="submit" class="btn btn-brand w-100 py-3 text-white fw-semibold">
            <i class="fa fa-paper-plane me-2"></i>
            Submit Request
        </button>
    </div>
</div>

</form>
                    

                </div>

            </div>
        </div>
    </div>
</div>
<!-- Callback End -->
