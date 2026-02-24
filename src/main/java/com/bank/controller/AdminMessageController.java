package com.bank.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bank.daoimpl.ContactMessageDaoImpl;
import com.bank.pojo.ContactMessage;
import com.bank.util.MailUtil;
@Controller
public class AdminMessageController {

    @Autowired
    private ContactMessageDaoImpl cimpl;

    @GetMapping("/incomingMessages")
    public String incomingMessages(HttpServletRequest request) {

        List<ContactMessage> messages = cimpl.getAllMessages();
        request.setAttribute("messages", messages);

        return "incomingMessages";
    }

    @GetMapping("/deleteMessage")
    public String deleteMessage(@RequestParam int id) {
        cimpl.deleteMessage(id);
        return "redirect:incomingMessages"; // 👈 SIMPLE
    }

    @GetMapping("/replyMessage")
    public String replyMessage(
            @RequestParam int id,
            HttpServletRequest request) {

        ContactMessage msg = cimpl.getMessageById(id);
        request.setAttribute("msg", msg);

        return "replyMessage"; // JSP page
    }
    
    @PostMapping("/sendReply")
    public String sendReply(
            @RequestParam int id,
            @RequestParam String email,
            @RequestParam String replyText) {

        try {

            // Message details nikal lo (name + subject ke liye)
            ContactMessage msg = cimpl.getMessageById(id);

            // 📧 FORMAL ADMIN REPLY MAIL
            MailUtil.sendAdminReplyMail(
                    email,                 // toEmail
                    msg.getName(),          // customerName
                    msg.getSubject(),       // originalSubject
                    replyText               // replyMessage
            );

            // ✅ Status update
            cimpl.updateStatus(id, "REPLIED");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:incomingMessages";
    }



}
