package com.bank.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bank.daoimpl.UsersDaoImpl;
import com.bank.pojo.Users;

@Controller
public class LoginController {

    @Autowired
    private UsersDaoImpl daoimpl;

    @PostMapping("/checkUser")
    public ModelAndView login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("captchaInput") String captchaInput,
            HttpServletRequest request) {

        ModelAndView mv = new ModelAndView();

        // ✅ existing session lo (captcha isi me hai)
        HttpSession session = request.getSession();

        if (session == null) {
            mv.setViewName("signIn");
            mv.addObject("msg", "Session expired. Please refresh.");
            return mv;
        }
        
        // ✅ CAPTCHA CHECK
        String sessionCaptcha = (String) session.getAttribute("captcha");

        if (sessionCaptcha == null ||
            captchaInput == null ||
            !sessionCaptcha.equalsIgnoreCase(captchaInput.trim())) {

            mv.setViewName("signIn");
            mv.addObject("msg", "Invalid Captcha");
            return mv;
        }

        // ✅ LOGIN CHECK
        Users user = daoimpl.checkUser(username, password);
        if (user == null) {
            mv.setViewName("signIn");
            mv.addObject("msg", "Invalid username/password");
            return mv;
        }
        
        // 🚫 BLOCKED USER CHECK
        if ("BLOCKED".equalsIgnoreCase(user.getStatus())) {
            mv.setViewName("contact");
            mv.addObject("msg", "You are blocked Kindly send an Request for Activation");
            return mv;
        }

        // ✅ SECURITY: old session destroy
        session.invalidate();

        // ✅ NEW SESSION create
        session = request.getSession(true);

        // ✅ SET LOGIN DATA
        session.setAttribute("loggedUser", user);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        if ("ADMIN".equalsIgnoreCase(user.getRole()))
        		
            mv.setViewName("redirect:/admin-Dashboard");
        else
            mv.setViewName("redirect:/user-Dashboard");

        return mv;
    }

  //==============================================================================================================
     
    // LOGOUT
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/index";
    }
    //==============================================================================================================
    

}
