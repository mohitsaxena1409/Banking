package com.bank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bank.dao.ContactMessageDao;
import com.bank.daoimpl.ContactMessageDaoImpl;
import com.bank.pojo.ContactMessage;
import com.bank.util.MailUtil;

@Controller
public class ContactController {

    @Autowired
    private ContactMessageDaoImpl cimpl;

    @PostMapping("/sendMessage")
    public ModelAndView sendMessage(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String mobile,
            @RequestParam String subject,
            @RequestParam String message) {

        ContactMessage msgObj = new ContactMessage();
        msgObj.setName(name);
        msgObj.setEmail(email);
        msgObj.setMobile(mobile);
        msgObj.setSubject(subject);
        msgObj.setMessage(message);

        cimpl.saveMessage(msgObj);
        MailUtil.sendContactQueryMail(
                email,
                name,
                mobile,
                subject,
                message
        );

        ModelAndView mv = new ModelAndView();
        mv.setViewName("contact"); // JSP name

        mv.addObject(
            "msg",
            "Message Sent Successfully! <br> Bank will approach and revert to you soon..."
        );

        return mv;
    }


}
