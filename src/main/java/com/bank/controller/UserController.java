package com.bank.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bank.daoimpl.BankAccountDaoImpl;
import com.bank.daoimpl.UsersDaoImpl;
import com.bank.pojo.BankAccount;
import com.bank.pojo.Users;
import com.bank.util.MailUtil;

@Controller
public class UserController {
	
	@Autowired
	BankAccountDaoImpl bankdaoimpl;
	
	@Autowired
	UsersDaoImpl daoimpl;
	//==============================================================================================
	@GetMapping("/user-Dashboard")
    public ModelAndView userDashboard(HttpServletRequest request) {

        ModelAndView mv = new ModelAndView("user-Dashboard");

        HttpSession session = request.getSession(false);
        if (session == null) {
            mv.setViewName("redirect:/index");
            return mv;
        }

        Users user = (Users) session.getAttribute("loggedUser");
        if (user == null) {
            mv.setViewName("redirect:/index");
            return mv;
        }

        // ✅ FETCH BANK ACCOUNT
        BankAccount acc = bankdaoimpl.getAccountByUserId(user.getId());

        // ✅ SEND TO JSP
        mv.addObject("account", acc);

        return mv;
    }
	//==============================================================================================
	
	//==============================================================================================
	// ================= SEND OTP =================
	@PostMapping("/send-update-otp")
	public String sendUpdateOtp(
	        @RequestParam String username,
	        @RequestParam String password,
	        HttpServletRequest request) {

	    HttpSession session = request.getSession(false);
	    if (session == null) return "redirect:/index";

	    Users u = (Users) session.getAttribute("loggedUser");
	    if (u == null) return "redirect:/index";

	    int otp = (int)(Math.random() * 900000) + 100000;

	    session.setAttribute("updateOtp", otp);
	    session.setAttribute("newUsername", username);
	    session.setAttribute("newPassword", password);

	    // SEND MAIL
	    MailUtil.sendOtpMail(u.getEmail(), otp);

	    request.setAttribute("msg", "OTP sent to your registered email");

	    return "verify-update-otp";   // ✅ OTP PAGE
	}


	// ================= VERIFY OTP =================
	@PostMapping("/verify-update-otp")
	public String verifyUpdateOtp(
	        @RequestParam("otp") Integer otp,
	        HttpServletRequest request) {

	    HttpSession session = request.getSession(false);
	    if (session == null) return "redirect:/index";

	    Users u = (Users) session.getAttribute("loggedUser");
	    Integer sessionOtp = (Integer) session.getAttribute("updateOtp");

	    if (otp == null || sessionOtp == null || !otp.equals(sessionOtp)) {
	        request.setAttribute("msg", "Invalid OTP");
	        return "verify-update-otp";
	    }

	    String username = (String) session.getAttribute("newUsername");
	    String password = (String) session.getAttribute("newPassword");

	    try {
	        daoimpl.updateProfile(u.getId(), username, password, u.getPhoto());
	    } catch (DuplicateKeyException e) {
	        request.setAttribute("msg", "Username already exists");
	        return "verify-update-otp";
	    }

	    u.setUsername(username);
	    u.setPassword(password);
	    session.setAttribute("loggedUser", u);

	    session.removeAttribute("updateOtp");
	    session.removeAttribute("newUsername");
	    session.removeAttribute("newPassword");

	    request.setAttribute("msg", "Details Updated Successfully");
	    return "signIn";
	}


	//===========================================================================================
	
	
}
