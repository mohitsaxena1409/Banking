package com.bank.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

import org.springframework.stereotype.Component;

@Component
public class MailUtil {

    //private static final String FROM_EMAIL = "keshavpatlawdiya@gmail.com";
    //private static final String PASSWORD   = "zmvzlqxsibqjtqlc";
    
    private static final String FROM_EMAIL = "shivamsolanki96300@gmail.com";
    private static final String PASSWORD   = "vfdpyduyzpzoabxb";

    
    //=================OTP FOR SIGNUP =========================
    	
    public static void sendSignupOtpMail(String toEmail, int otp) {

        String subject = "Email Verification OTP | Aashray UniTrust Bank";

        String body =
            "<p>Dear Customer,</p>" +
            "<p>Thank you for registering with <b>Aashray UniTrust Bank</b>.</p>" +
            "<p>Please use the following OTP to verify your email address:</p>" +
            "<h2 style='color:#011A41; letter-spacing:2px;'>" + otp + "</h2>" +
            "<p>This OTP is valid for <b>5 minutes</b>.</p>" +
            "<p>If you did not initiate this request, please ignore this email.</p>" +
            "<p>Regards,<br><b>Aashray UniTrust Bank</b></p>";

        sendMailInternal(toEmail, subject, body);
    }

    
    
    // =========================================================
    // COMMON INTERNAL METHOD (REAL MAIL SENDER)
    // =========================================================
    private static void sendMailInternal(String toEmail, String subject, String body) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject(subject);
            message.setContent(body, "text/html");

            Transport.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================================================
    // PENDING MAIL (SIGNUP TIME)
    // =========================================================
    public static void sendMail(String toEmail, String fname, String phone) {

        String subject = "Your Account Request – Pending for Verification";

        String body =
                "<p>Dear <strong>" + fname + "</strong>,</p>" +
                "<p>Your account request is currently <strong>pending for verification</strong>.</p>" +
                "<p><strong>Registered Phone:</strong> " + phone + "</p>" +
                "<p>Warm regards,<br>Aashray UniTrust Bank</p>";

        sendMailInternal(toEmail, subject, body);
    }

    // =========================================================
    // APPROVAL MAIL (ADMIN APPROVE)
    // =========================================================
    public static void sendApprovalMail(
            String toEmail,
            String fname,
            String username,
            String password,
            String accountNo
    ) {

        String subject = "Your Bank Account Has Been Approved 🎉";

        String body =
                "<p>Dear " + fname + ",</p>" +

                "<p>We are pleased to inform you that your bank account has been "
              + "<b>successfully approved</b>. You can now access our banking services.</p>" +

                "<p>Please find your login credentials below:</p>" +

                "<table border='1' cellpadding='10' cellspacing='0' style='border-collapse:collapse;'>" +
                "<tr style='background-color:#f2f2f2;'>" +
                "<th align='left'>Account Number</th><td>" + accountNo + "</td></tr>" +
                "<tr><th align='left'>Username</th><td>" + username + "</td></tr>" +
                "<tr><th align='left'>Password</th><td>" + password + "</td></tr>" +
                "</table>" +

                "<p><b>Important:</b> For security reasons, please change your password "
              + "after your first login.</p>" +

                "<p>If you have any questions or require assistance, feel free to contact our support team.</p>" +

                "<p>Warm regards,<br>" +
                "<b>Customer Support Team</b><br>" +
                "Aashray UniTrust Bank</p>";

        sendMailInternal(toEmail, subject, body);
    }
    //============================================================================================
    //USERNAME AND PASSWORD UPDATE KRTE TIME KA MAIL WITH OTP....
 // =========================================================
 // OTP MAIL (PROFILE UPDATE VERIFICATION)
 // =========================================================
 public static void sendOtpMail(String toEmail, int otp) {

     String subject = "OTP Verification for Profile Update";

     String body =
             "<p>Dear Customer,</p>" +

             "<p>We received a request to <b>update your profile details</b> "
           + "on your Aashray UniTrust Bank account.</p>" +

             "<p>Please use the following <b>One-Time Password (OTP)</b> to proceed:</p>" +

             "<h2 style='color:#2e86de; letter-spacing:2px;'>" + otp + "</h2>" +

             "<p>This OTP is <b>valid for a short time</b>. "
           + "Please do not share it with anyone.</p>" +

             "<p>If you did not request this change, please contact our support team immediately.</p>" +

             "<p>Warm regards,<br>" +
             "<b>Security Team</b><br>" +
             "Aashray UniTrust Bank</p>";

     sendMailInternal(toEmail, subject, body);
 }
		//=========================================================
		//DEBIT MAIL (SENDER)
		//=========================================================
		public static void sendDebitMail(
		      String toEmail,
		      String name,
		      double amount,
		      String accountNo,
		      double balance
		) {
		
		  String subject = "Amount Debited Alert";
		
		  String body =
		      "<p>Dear " + name + ",</p>" +
		
		      "<p>Rs. <b>" + amount + "</b> has been <b>debited</b> from your account.</p>" +
		
		      "<p><b>Account:</b> XXXXX" + accountNo.substring(accountNo.length()-4) + "</p>" +
		      "<p><b>Available Balance:</b> Rs." + balance + "</p>" +
		
		      "<p>If this was not you, please contact bank support immediately.</p>" +
		
		      "<p>Regards,<br>Aashray UniTrust Bank</p>";
		
		  sendMailInternal(toEmail, subject, body);
		}
		
		
		//=========================================================
		//CREDIT MAIL (RECEIVER)
		//=========================================================
		public static void sendCreditMail(
		      String toEmail,
		      String name,
		      double amount,
		      String fromAccount
		) {
		
		  String subject = "Amount Credited Alert";
		
		  String body =
		      "<p>Dear " + name + ",</p>" +
		
		      "<p>Rs. <b>" + amount + "</b> has been <b>credited</b> to your account.</p>" +
		
		      "<p><b>From :</b> XXXXX" +
		      fromAccount.substring(fromAccount.length()-4) + "</p>" +
		
		      "<p>Regards,<br>Aashray UniTrust Bank</p>";
		
		  sendMailInternal(toEmail, subject, body);
		}
		
		// =========================================================
		// ACCOUNT BLOCKED MAIL (ADMIN ACTION)
		// =========================================================
		public static void sendAccountBlockedMail(
		        String toEmail,
		        String name,
		        String accountNo
		) {

		    String subject = "Important Notice: Bank Account Blocked";

		    String body =
		        "<p>Dear " + name + ",</p>" +

		        "<p>This is to inform you that your bank account "
		      + "<b>XXXX" + accountNo.substring(accountNo.length() - 4) + "</b> "
		      + "has been <b>temporarily blocked</b> due to administrative or security reasons.</p>" +

		        "<p>During this period, all transactions on your account are restricted.</p>" +

		        "<p>For further clarification, please contact our bank support team.</p>" +

		        "<p>Regards,<br>" +
		        "<b>Aashray UniTrust Bank</b></p>";

		    sendMailInternal(toEmail, subject, body);
		}
		// =========================================================
		// ACCOUNT ACTIVATE MAIL (ADMIN ACTION)
		// =========================================================
		public static void sendAccountActivationMail(
		        String toEmail,
		        String name,
		        String accountNo
		) {

		    String subject = "✔ Account Activated Successfully | Aashray UniTrust Bank";

		    String body =
		        "<p>Dear " + name + ",</p>" +

		        "<p>We are pleased to inform you that your bank account " +
		        "<b>XXXX" + accountNo.substring(accountNo.length() - 4) + "</b> " +
		        "has been <b>successfully activated</b>.</p>" +

		        "<p>You may now access all banking services including deposits, withdrawals, " +
		        "and fund transfers.</p>" +

		        "<p>If you have any questions or require assistance, please contact our bank support team.</p>" +

		        "<p>Regards,<br>" +
		        "<b>Aashray UniTrust Bank</b></p>";

		    sendMailInternal(toEmail, subject, body);
		}

		// =========================================================
		// CONTACT / QUERY MAIL (CONTACT FORM)
		// =========================================================
		public static void sendContactQueryMail(
		        String toEmail,
		        String name,
		        String mobile,
		        String subjectText,
		        String messageText
		) {

		    String subject = "Query Received | Aashray UniTrust Bank";

		    String body =
		            "<p>Dear <b>" + name + "</b>,</p>" +

		            "<p>Thank you for contacting <b>Aashray UniTrust Bank</b>.</p>" +

		            "<p>We have successfully received your query with the following details:</p>" +

		            "<table border='1' cellpadding='10' cellspacing='0' style='border-collapse:collapse;'>" +
		            "<tr><th align='left'>Subject</th><td>" + subjectText + "</td></tr>" +
		            "<tr><th align='left'>Mobile</th><td>" + mobile + "</td></tr>" +
		            "<tr><th align='left'>Message</th><td>" + messageText + "</td></tr>" +
		            "</table>" +

		            "<p>Our support team will review your request and contact you shortly.</p>" +

		            "<p>Regards,<br>" +
		            "<b>Customer Support Team</b><br>" +
		            "Aashray UniTrust Bank</p>";

		    sendMailInternal(toEmail, subject, body);
		}
		
		// =========================================================
		// ADMIN → CUSTOMER REPLY MAIL (FORMAL & PROFESSIONAL)
		// =========================================================
		public static void sendAdminReplyMail(
		        String toEmail,
		        String customerName,
		        String originalSubject,
		        String replyMessage
		) {

		    String subject = "Response to Your Query | Aashray UniTrust Bank";

		    String body =
		            "<div style='font-family:Arial, sans-serif; font-size:14px; color:#333;'>" +

		            "<p>Dear <b>" + customerName + "</b>,</p>" +

		            "<p>Thank you for reaching out to <b>Aashray UniTrust Bank</b>.</p>" +

		            "<p>With reference to your query regarding "
		          + "<b>\"" + originalSubject + "\"</b>, please find our response below:</p>" +

		            "<div style='border-left:4px solid #2e86de; padding:10px; background:#f9f9f9;'>" +
		            replyMessage +
		            "</div>" +

		            "<p>If you require any further assistance or clarification, "
		          + "please feel free to reply to this email or contact our customer support team.</p>" +

		            "<p>We value your relationship with Aashray UniTrust Bank "
		          + "and look forward to serving you.</p>" +

		            "<p>Warm regards,<br>" +
		            "<b>Customer Support Team</b><br>" +
		            "Aashray UniTrust Bank<br>" +
		            "📞 Toll Free: 1800-000-000<br>" +
		            "🌐 www.aashrayunitrustbank.com</p>" +

		            "<hr style='border:none;border-top:1px solid #ddd;'>" +
		            "<p style='font-size:11px; color:#777;'>" +
		            "This is a system-generated email. Please do not share confidential "
		          + "information such as OTP, PIN, or passwords via email." +
		            "</p>" +

		            "</div>";

		    sendMailInternal(toEmail, subject, body);
		}
		// =========================================================
		// PROFILE UPDATE SUCCESS MAIL
		// =========================================================
		public static void sendProfileUpdatedMail(
		        String toEmail,
		        String name
		) {

		    String subject = "✔ Profile Updated Successfully | Aashray UniTrust Bank";

		    String body =
		        "<p>Dear <b>" + name + "</b>,</p>" +

		        "<p>This is to inform you that your <b>profile details have been "
		      + "successfully updated</b> in our banking system.</p>" +

		        "<p>If you made these changes, no further action is required.</p>" +

		        "<p><b>Security Notice:</b> If you did not request this update, "
		      + "please contact our bank support team immediately.</p>" +

		        "<p>Regards,<br>" +
		        "<b>Aashray UniTrust Bank</b></p>";

		    sendMailInternal(toEmail, subject, body);
		}


    
}

