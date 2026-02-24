<!DOCTYPE html>
<html lang="en">
<style>
    .mycolor{
        background:#011A41 !important;
        color:white !important;
    }
    .text-logo{
        color:#011A41 !important;
    }

    /* FAQ Styling */
    .faq-item{
        border:none;
        margin-bottom:15px;
        border-radius:10px;
        overflow:hidden;
        box-shadow:0 4px 14px rgba(0,0,0,0.08);
    }

    .faq-btn{
        background:#011A41 !important;
        color:#fff !important;
        font-weight:600;
    }

    .faq-btn::after{
        filter: brightness(0) invert(1);
    }

    .faq-body{
        background:#f8f9fa;
        color:#333;
        line-height:1.7;
    }
    </style>
<head>
    <meta charset="utf-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
    <title>Aashray-UniTrust Bank</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;500&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner"
        class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;"></div>
    </div>
    <!-- Spinner End -->


    

    <%@include file="header.jsp" %>


   <!-- Page Header Start -->
<div class="container-fluid page-header mb-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container text-center">

        <%@ include file="CallBackSection.jsp" %>

        <nav aria-label="breadcrumb" class="animated slideInDown mt-3">
            <ol class="breadcrumb justify-content-center mb-0">
               
            </ol>
        </nav>

    </div>
</div>
<!-- Page Header End -->



<!-- ================= FAQ SECTION END ================= --> 
    
    
    <!-- ================= FAQ SECTION START ================= -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">

            <div class="text-center mb-5">
                <h2 class="text-logo mb-3">Frequently Asked Questions</h2>
                <p>Common banking queries and their answers</p>
            </div>

            <div class="accordion" id="bankFaq">

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq1">
                        What documents are required to open a bank account?
                    </button>
                    <div id="faq1" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            You need a valid ID proof, address proof, PAN card and a recent passport-size photograph.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq2">
                        Why is my account blocked?
                    </button>
                    <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            Accounts may be blocked due to multiple failed login attempts or security verification issues.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq3">
                        How can I reactivate my blocked account?
                    </button>
                    <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            Your account can be reactivated after admin verification. You will be notified via email.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq4">
                        Why do I receive an OTP for transactions?
                    </button>
                    <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            OTP adds an extra layer of security to prevent unauthorized transactions.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq5">
                        How can I check my transaction history?
                    </button>
                    <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            Login to your account and visit the Transactions section to view detailed history.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq6">
                        What should I do if I forget my password?
                    </button>
                    <div id="faq6" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            Use the "Forgot Password" option to reset your password using OTP verification.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq7">
                        Is online banking safe?
                    </button>
                    <div id="faq7" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            Yes, online banking is safe when using strong passwords and OTP-based authentication.
                        </div>
                    </div>
                </div>

                <div class="accordion-item faq-item">
                    <button class="accordion-button collapsed faq-btn" data-bs-toggle="collapse" data-bs-target="#faq8">
                        Can I update my personal details online?
                    </button>
                    <div id="faq8" class="accordion-collapse collapse" data-bs-parent="#bankFaq">
                        <div class="accordion-body faq-body">
                            Yes, users can update their profile details after logging into their account.
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Map Start -->
<div class="container-fluid px-0 wow fadeIn" data-wow-delay="0.1s">
    <div class="row g-0">
        <div class="col-12" style="min-height: 450px;">
            <iframe
                class="w-100 h-100"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3001156.4288297426!2d-78.01371936852176!3d42.72876761954724!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4ccc4bf0f123a5a9%3A0xddcfc6c1de189567!2sNew%20York%2C%20USA!5e0!3m2!1sen!2sbd!4v1603794290143!5m2!1sen!2sbd"
                style="border:0; min-height:450px;"
                allowfullscreen
                loading="lazy">
            </iframe>
        </div>
    </div>
</div>
<!-- Map End -->

<%@include file="Footer.jsp"%>
    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i
            class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>