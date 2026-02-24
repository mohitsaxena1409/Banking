package com.bank.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bank.daoimpl.BankAccountDaoImpl;
import com.bank.daoimpl.TransactionDaoImpl;
import com.bank.daoimpl.UsersDaoImpl;
import com.bank.pojo.BankAccount;
import com.bank.pojo.Transaction;
import com.bank.pojo.Users;
import com.bank.util.MailUtil;

@Controller
public class TransactionController {

    @Autowired
    private BankAccountDaoImpl bankdaoimpl;

    @Autowired
    private TransactionDaoImpl tnxdaoimpl;

    @Autowired
    private UsersDaoImpl daoimpl;

    // ================= TRANSFER MONEY =================
    @PostMapping("/transferMoney")
    public String transferMoney(
            @RequestParam String toAccount,
            @RequestParam double amount,
            @RequestParam String mode,
            HttpSession session) {

        // ================= SESSION CHECK =================
        Users user = (Users) session.getAttribute("loggedUser");
        if (user == null) {
            return "redirect:/index";
        }

        // ================= FETCH SENDER =================
        BankAccount sender = bankdaoimpl.getAccountByUserId(user.getId());

        // ================= FETCH RECEIVER =================
        BankAccount receiver = bankdaoimpl.getAccountByAccountNo(toAccount);

        // ❌ Receiver not found
        if (receiver == null) {
            session.setAttribute("msg", "Invalid beneficiary account");
            return "redirect:/user-Dashboard";
        }

        // ❌ Self transfer
        if (sender.getAccountNo().equals(toAccount)) {
            session.setAttribute("msg", "You cannot transfer money to your own account");
            return "redirect:/user-Dashboard";
        }

        // ❌ Insufficient balance
        if (sender.getOpeningBalance() < amount) {
            session.setAttribute("msg", "Insufficient balance");
            return "redirect:/user-Dashboard";
        }

        // ❌ RTGS rule
        if ("RTGS".equalsIgnoreCase(mode) && amount < 200000) {
            session.setAttribute("msg", "RTGS minimum amount is 2,00,000");
            return "redirect:/user-Dashboard";
        }

        // ❌ Sender blocked
        if ("BLOCKED".equalsIgnoreCase(sender.getStatus())) {
            session.setAttribute("msg", "Your account is blocked. Transaction not allowed.");
            return "redirect:/user-Dashboard";
        }

        // ❌ Receiver blocked
        if ("BLOCKED".equalsIgnoreCase(receiver.getStatus())) {
            session.setAttribute("msg", "Beneficiary account is blocked. Payment not allowed.");
            return "redirect:/user-Dashboard";
        }

        // ================= BALANCE UPDATE =================
        bankdaoimpl.deductBalance(sender.getAccountNo(), amount);
        bankdaoimpl.addBalance(receiver.getAccountNo(), amount);

        // ================= SAVE TRANSACTION =================
        Transaction txn = new Transaction();
        txn.setFromAccount(sender.getAccountNo());
        txn.setToAccount(receiver.getAccountNo());
        txn.setAmount(amount);
        txn.setMode(mode);
        txn.setStatus("SUCCESS");
        txn.setReferenceId("TXN" + System.currentTimeMillis());
        tnxdaoimpl.saveTransaction(txn);

        // ================= MAIL =================
        try {
            Users receiverUser =
                    daoimpl.getUserByAccountNo(receiver.getAccountNo());

            MailUtil.sendDebitMail(
                    user.getEmail(),
                    user.getFname(),
                    amount,
                    sender.getAccountNo(),
                    sender.getOpeningBalance() - amount
            );

            MailUtil.sendCreditMail(
                    receiverUser.getEmail(),
                    receiverUser.getFname(),
                    amount,
                    sender.getAccountNo()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ================= SUCCESS =================
        session.setAttribute("msg", "Money transferred successfully");
        return "redirect:/user-Dashboard";
    }

    // ================= VIEW TRANSACTIONS =================
    @GetMapping("/view-transactions")
    public ModelAndView viewTransactions(HttpSession session) {

        Users user = (Users) session.getAttribute("loggedUser");
        if (user == null) {
            return new ModelAndView("redirect:/signIn");
        }

        BankAccount acc =
                bankdaoimpl.getAccountByUserId(user.getId());

        List<Transaction> list =
        		tnxdaoimpl.getTransactionsByAccount(
                        acc.getAccountNo()
                );

        ModelAndView mv = new ModelAndView("transactions");
        mv.addObject("transactions", list);
        mv.addObject("user", user);              // ✅ account holder
        mv.addObject("account", acc); 
        return mv;
    }

}
