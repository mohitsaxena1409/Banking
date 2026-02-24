package com.bank.controller;

import java.io.File;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bank.daoimpl.BankAccountDaoImpl;
import com.bank.daoimpl.TransactionDaoImpl;
import com.bank.daoimpl.UsersDaoImpl;
import com.bank.pojo.BankAccount;
import com.bank.pojo.Transaction;
import com.bank.pojo.Users;
import com.bank.util.MailUtil;

@Controller
public class AdminController {
	
	@Autowired
    private UsersDaoImpl daoimpl;
	
	@Autowired
    private BankAccountDaoImpl bankdaoimpl;
	
	@Autowired
    private TransactionDaoImpl tnxdaoimpl;
	
	//============================================================================================
	 @GetMapping("/admin-Dashboard")
	    public ModelAndView adminDashboard(HttpServletRequest request) {

	        HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("loggedUser") == null) {
	            return new ModelAndView("redirect:/signIn");
	        }

	        Users admin = (Users) session.getAttribute("loggedUser");

	        ModelAndView mv = new ModelAndView("admin-Dashboard");
	        mv.addObject("admin", admin);
	        mv.addObject("usersList", daoimpl.getPendingUsers());

	        return mv;
	    }

	
	//=============================================================================================
	

	//=============================================================================================
	@GetMapping("/viewUser")
	public ModelAndView viewUser(@RequestParam int id) {

	    Users user = daoimpl.getUserById(id);
	    ModelAndView mv = new ModelAndView("viewUserDetails");
	    mv.addObject("user", user);

	    return mv;
	}
	//=============================================================================================

	@GetMapping("/approveForm")
	public ModelAndView approveForm(@RequestParam int id) {

	    Users user = daoimpl.getUserById(id);

	    // ===== AUTO-GENERATED BANK DATA =====
	    String accountNo = "23"+System.currentTimeMillis();
	    String username = user.getFname().toLowerCase()+id;
	    String password = "PWD" + (int)(Math.random() * 10000);

	    ModelAndView mv = new ModelAndView("approve-user");
	    mv.addObject("user", user);
	    mv.addObject("accountNo", accountNo);
	    mv.addObject("username", username);
	    mv.addObject("password", password);

	    return mv;
	}

	//=============================================================================================
	@PostMapping("/finalApprove")
	public String finalApprove(
	        @RequestParam int id,
	        @RequestParam String accountno,
	        @RequestParam String branch,
	        @RequestParam double balance,
	        @RequestParam String username,
	        @RequestParam String password,
	        @RequestParam String email,
	        @RequestParam String fname,
	        HttpSession session) {   // 👈 add this

	    String ifsc = "AA23000" + branch.substring(0, 3).toUpperCase();

	    daoimpl.finalApproveUser(
	        id, accountno, ifsc, branch, balance, username, password
	    );

	    // ✅ Mail sent
	    MailUtil.sendApprovalMail(
	        email,
	        fname,
	        username,
	        password,
	        accountno
	    );

	    // ✅ PROFESSIONAL ADMIN MESSAGE
	    session.setAttribute(
	        "msg",
	        "User approved successfully. Account activated and approval email sent to the registered email address."
	    );

	    return "redirect:/admin-Dashboard";
	}



    //==================================UPDATE USERS FROM ADMINPANEL===================================
	@GetMapping("/updateUsers")
	public String updateUsers(HttpServletRequest req, HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return "redirect:signIn";
	    }

	    req.setAttribute("usersList", daoimpl.getActiveUsers());
	    return "update-users";   // JSP
	}

//==================================================================================================
	@GetMapping("/editUser")
	public String editUser(@RequestParam int id,
	                       HttpServletRequest req,
	                       HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null) return "redirect:signIn";

	    Users user = daoimpl.getActiveUserById(id);
	    if (user == null) {
	        return "redirect:/updateUsers";  // ✔
	    }

	    req.setAttribute("user", user);
	    return "user-form";
	}


//==============================================================================
	@PostMapping("/updateUser")
	public String updateUser(
	        @RequestParam Integer id,
	        @RequestParam String fname,
	        @RequestParam String lname,
	        @RequestParam String dob,
	        @RequestParam String gender,
	        @RequestParam String phone,
	        @RequestParam String address,
	        @RequestParam String city,
	        @RequestParam String state,
	        @RequestParam int pincode,
	        HttpSession session
	) {

	    if (id == null || id <= 0) {
	        session.setAttribute("msg", "Invalid User ID");
	        return "redirect:/updateUsers";
	    }

	    Users u;
	    try {
	        u = daoimpl.getActiveUserById(id);
	    } catch (org.springframework.dao.EmptyResultDataAccessException e) {
	        session.setAttribute("msg", "User not found");
	        return "redirect:/updateUsers";
	    }

	    try {
	        // ===== UPDATE BASIC DETAILS =====
	        u.setFname(fname);
	        u.setLname(lname);
	        u.setDob(java.sql.Date.valueOf(dob));
	        u.setGender(gender);
	        u.setPhone(phone);
	        u.setAddress(address);
	        u.setCity(city);
	        u.setState(state);
	        u.setPincode(pincode);

	        daoimpl.updatePersonalAddress(u);
	        
	        
	        MailUtil.sendProfileUpdatedMail(
	        	    u.getEmail(),
	        	    u.getFname() + " " + u.getLname()
	        	);

	        session.setAttribute("msg", "User updated successfully");
	        return "redirect:/updateUsers";

	    } catch (Exception e) {
	        e.printStackTrace();
	        session.setAttribute("msg", "Update failed");
	        return "redirect:/updateUsers";
	    }
	}



//======================================SEARCH USER ==================================================
	// =====================================================
    // SEARCH ACCOUNT → ADMIN USER ACTION PAGE
    // =====================================================
    @GetMapping("/admin-user-actions")
    public ModelAndView adminUserActions(
            @RequestParam String accountNo,
            HttpSession session) {

        BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);

        if (acc == null) {
            session.setAttribute("msg", "Account not found");
            return new ModelAndView("redirect:/admin-Dashboard");
        }

        if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) {
            session.setAttribute("msg", "User account is blocked");
            return new ModelAndView("redirect:/admin-Dashboard");
        }

        Users user = bankdaoimpl.getUserByAccId(acc.getId());

        List<Transaction> txList =
                tnxdaoimpl.getTransactionsByAccount(accountNo);
        ModelAndView mv = new ModelAndView("admin-user-actions");
        mv.addObject("user", user);
        mv.addObject("account", acc);
        mv.addObject("txList", txList);

        return mv;
    }

    // =====================================================
    // ADMIN DEPOSIT (JDBC)
    // =====================================================
    @PostMapping("/adminDeposit")
    public ModelAndView adminDeposit(
            @RequestParam String accountNo,
            @RequestParam double amount,
            HttpSession session) {

        BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);

        if (acc == null) {
            session.setAttribute("msg", "Account not found");
            return new ModelAndView("redirect:/admin-Dashboard");
        }

        if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) {
            session.setAttribute("msg", "Account is blocked");
            return new ModelAndView("redirect:/admin-Dashboard");
        }

        if (amount <= 0) {
            session.setAttribute("msg", "Invalid deposit amount");
            return new ModelAndView("redirect:/admin-user-actions?accountNo=" + accountNo);
        }

        // 💰 Deposit
        bankdaoimpl.addBalance(accountNo, amount);

        // 🧾 Transaction entry
        Transaction tx = new Transaction();
        tx.setFromAccount("Aashray Bank");
        tx.setToAccount(accountNo);
        tx.setAmount(amount);
        tx.setMode("DEPOSIT");
        tx.setStatus("SUCCESS");
        tx.setReferenceId("DEP" + System.currentTimeMillis());

        tnxdaoimpl.saveTransaction(tx);

        // 📧 CREDIT MAIL (ADDED – no logic change)
        
        BankAccount updatedAcc = bankdaoimpl.getAccountByAccountNo(accountNo);
        Users user = bankdaoimpl.getUserByAccId(updatedAcc.getId());

        
        MailUtil.sendCreditMail(
                user.getEmail(),
                user.getFname(),
                amount,
                "Aashray Bank"
        );
        session.setAttribute("msg", "Amount deposited successfully");

        return new ModelAndView("redirect:/admin-user-actions?accountNo=" + accountNo);
    }

    // =====================================================
    // ADMIN WITHDRAW (JDBC)
    // =====================================================
    @PostMapping("/adminWithdraw")
    public ModelAndView adminWithdraw(
            @RequestParam String accountNo,
            @RequestParam double amount,
            HttpSession session) {

        BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);

        if (acc == null) {
            session.setAttribute("msg", "Account not found");
            return new ModelAndView("redirect:/admin-Dashboard");
        }

        if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) {
            session.setAttribute("msg", "Account is blocked");
            return new ModelAndView("redirect:/admin-Dashboard");
        }

        if (amount <= 0) {
            session.setAttribute("msg", "Invalid withdrawal amount");
            return new ModelAndView("redirect:/admin-user-actions?accountNo=" + accountNo);
        }

        if (acc.getOpeningBalance() < amount) {
            session.setAttribute("msg", "Insufficient balance");
            return new ModelAndView("redirect:/admin-user-actions?accountNo=" + accountNo);
        }

        // 💸 Withdraw
        bankdaoimpl.deductBalance(accountNo, amount);

        // 🧾 Transaction entry
        Transaction tx = new Transaction();
        tx.setFromAccount(accountNo);
        tx.setToAccount("Aashray Bank");
        tx.setAmount(amount);
        tx.setMode("WITHDRAW");
        tx.setStatus("SUCCESS");
        tx.setReferenceId("DEP" + System.currentTimeMillis());

        tnxdaoimpl.saveTransaction(tx);
        
        // 📧 MAIL (ONLY ADDITION)
        BankAccount updatedAcc = bankdaoimpl.getAccountByAccountNo(accountNo);
        Users user = bankdaoimpl.getUserByAccId(updatedAcc.getId());

        MailUtil.sendDebitMail(
                user.getEmail(),
                user.getFname(),
                amount,
                accountNo,
                updatedAcc.getOpeningBalance()
        );

        session.setAttribute("msg", "Amount withdrawn successfully");

        return new ModelAndView("redirect:/admin-user-actions?accountNo=" + accountNo);
    }
	
	



}
