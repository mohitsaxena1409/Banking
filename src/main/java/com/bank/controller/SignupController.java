package com.bank.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bank.dao.UsersDao;
import com.bank.daoimpl.UsersDaoImpl;
import com.bank.pojo.Users;
import com.bank.util.MailUtil;

@Controller
public class SignupController {

    @Autowired
    private UsersDaoImpl daoimpl;

    @PostMapping("/signUp")
    public ModelAndView signUp(
            @RequestParam String fname,
            @RequestParam String lname,
            @RequestParam String dob,
            @RequestParam String gender,

            @RequestParam String phone,
            @RequestParam String email,

            @RequestParam String address,
            @RequestParam String city,
            @RequestParam String state,
            @RequestParam int pincode,

            @RequestParam long aadharno,
            @RequestParam String panno,

            @RequestParam MultipartFile photo,
            @RequestParam MultipartFile signature,
            @RequestParam MultipartFile aadhardoc,
            @RequestParam MultipartFile pandoc,

            @RequestParam String accounttype,
            @RequestParam String modeofoperation,
            @RequestParam int atmfacility,
            @RequestParam int chequebook,

            HttpServletRequest request
    ) {

        ModelAndView mv = new ModelAndView();

        try {
        
        	// ========= OTP VERIFICATION CHECK =========
            Boolean verified =
                (Boolean) request.getSession().getAttribute("OTP_VERIFIED");

            if (verified == null || !verified) {
                mv.setViewName("signUp");
                mv.addObject("msg", "Please verify email OTP first");
                return mv;
            }
        	
        	// ================= AADHAR CHECK =================
            if (daoimpl.isAadharExists(aadharno)) {
                mv.setViewName("signUp");
                mv.addObject("msg", "Aadhar number already registered!");
                return mv;
            }

            // ================= PAN CHECK =================
            if (daoimpl.isPanExists(panno)) {
                mv.setViewName("signUp");
                mv.addObject("msg", "PAN number already registered!");
                return mv;
            }

            
            /* ===== BASE PATH ===== */
            String basePath = request.getServletContext().getRealPath("/assets/");

            String photoPath  = basePath + "users/";
            String signPath   = basePath + "Documents/Signature/";
            String aadPath    = basePath + "Documents/Aadhar/";
            String panPath    = basePath + "Documents/PAN/";

            new File(photoPath).mkdirs();
            new File(signPath).mkdirs();
            new File(aadPath).mkdirs();
            new File(panPath).mkdirs();

            /* ===== FILE NAMES ===== */
            String photoName = System.currentTimeMillis() + "_" + photo.getOriginalFilename();
            String signName  = System.currentTimeMillis() + "_" + signature.getOriginalFilename();
            String aadName   = System.currentTimeMillis() + "_" + aadhardoc.getOriginalFilename();
            String panName   = System.currentTimeMillis() + "_" + pandoc.getOriginalFilename();

            /* ===== SAVE FILES ===== */
            photo.transferTo(new File(photoPath + photoName));
            signature.transferTo(new File(signPath + signName));
            aadhardoc.transferTo(new File(aadPath + aadName));
            pandoc.transferTo(new File(panPath + panName));

            /* ===== USERS OBJECT ===== */
            Users u = new Users();
            u.setFname(fname);
            u.setLname(lname);
            u.setDob(Date.valueOf(LocalDate.parse(dob)));
            u.setGender(gender);

            u.setPhone(phone);
            u.setEmail(email);

            u.setAddress(address);
            u.setCity(city);
            u.setState(state);
            u.setPincode(pincode);

            u.setAadharno(aadharno);
            u.setPanno(panno);

            u.setPhoto(photoName);
            u.setSignature(signName);
            u.setAadhardoc(aadName);
            u.setPandoc(panName);

            u.setAccounttype(accounttype);
            u.setModeofoperation(modeofoperation);
            u.setAtmfacility(atmfacility);
            u.setChequebook(chequebook);

            u.setRole("CUSTOMER");
            u.setStatus("PENDING");
            
            
         
            int res = daoimpl.saveUser(u);

            if (res > 0) {
                MailUtil.sendMail(
                    u.getEmail(),
                    u.getFname(),
                    u.getPhone()
                );

                mv.setViewName("signIn");
                mv.addObject("msg", "Registration successfull ! Await for admin approval.");
            } else {
                mv.setViewName("signUp");
                mv.addObject("msg", "Registration failed.");
            }


        }catch (IOException e) {
            e.printStackTrace();
            mv.setViewName("signUp");
            mv.addObject("msg", "File upload failed. Please upload valid files.");
        }
        catch (IllegalArgumentException e) {
            e.printStackTrace();
            mv.setViewName("signUp");
            mv.addObject("msg", "Invalid data provided.");
        }
        catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("signUp");
            mv.addObject("msg", "Something went wrong. Please try again.");
        }

        return mv;
    }
    
 // ========= SEND OTP =========
    @PostMapping("/sendSignupOtp")
    @ResponseBody
    public String sendSignupOtp(
            @RequestParam String email,
            HttpSession session
    ) {
        int otp = (int)(Math.random() * 900000) + 100000;

        session.setAttribute("SIGNUP_OTP", otp);
        session.setAttribute("OTP_TIME", System.currentTimeMillis());
        session.setAttribute("OTP_VERIFIED", false);

        MailUtil.sendSignupOtpMail(email, otp);

        return "SENT";
    }

    // ========= VERIFY OTP =========
    @PostMapping("/verifySignupOtp")
    @ResponseBody
    public String verifySignupOtp(
            @RequestParam int otp,
            HttpSession session
    ) {
        Integer sessionOtp = (Integer) session.getAttribute("SIGNUP_OTP");
        Long otpTime = (Long) session.getAttribute("OTP_TIME");

        if (sessionOtp == null || otpTime == null) {
            return "EXPIRED";
        }

        // 5 minutes
        if (System.currentTimeMillis() - otpTime > 5 * 60 * 1000) {
            session.removeAttribute("SIGNUP_OTP");
            session.removeAttribute("OTP_TIME");
            session.setAttribute("OTP_VERIFIED", false);
            return "EXPIRED";
        }


        if (otp == sessionOtp) {
            session.setAttribute("OTP_VERIFIED", true);
            return "SUCCESS";
        }

        return "INVALID";
    }
}
