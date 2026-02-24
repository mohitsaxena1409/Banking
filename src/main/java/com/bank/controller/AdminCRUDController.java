package com.bank.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
public class AdminCRUDController {

    private final MailUtil mailUtil;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
		
	@Autowired
	private UsersDaoImpl daoimpl;
	
	@Autowired
	private BankAccountDaoImpl bankdaoimpl;
	
	@Autowired
	private TransactionDaoImpl tnxdaoimpl;
	

    AdminCRUDController(MailUtil mailUtil) {
        this.mailUtil = mailUtil;
    }
	
	@PostMapping("/addUser")
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
        	
        	// ================= AADHAR CHECK =================
            if (daoimpl.isAadharExists(aadharno)) {
                mv.setViewName("add-user");
                mv.addObject("msg", "Aadhar number already registered!");
                return mv;
            }

            // ================= PAN CHECK =================
            if (daoimpl.isPanExists(panno)) {
                mv.setViewName("add-user");
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
                request.getSession().setAttribute(
                    "msg",
		                    "User Added Successfully! Please approve user."
		                );
		                mv.setViewName("admin-Dashboard");
		    }
            else {
			 	mv.setViewName("add-user");
                mv.addObject("msg", "Registration failed, Due TO Server Error");
            }


        }catch (IOException e) {
            e.printStackTrace();
            mv.setViewName("add-user");
            mv.addObject("msg", "File upload failed. Please upload valid files.");
        }
        catch (IllegalArgumentException e) {
            e.printStackTrace();
            mv.setViewName("add-user");
            mv.addObject("msg", "Invalid data provided.");
        }
        catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("add-user");
            mv.addObject("msg", "Something went wrong. Please try again.");
        }

        return mv;
    }
	
	//=============================================================================
	// ================= SHOW ALL USERS + ACCOUNTS =================
	@GetMapping("/showAllAccounts")
	public String showAllAccounts(Model model) {

	    List<Users> list =
	        daoimpl.fetchAllUsersWithAccounts();

	    model.addAttribute("usersList", list);
	    return "showAllAccounts";
	}
	//=================================================================================
	//====================ALL VIEW DETAILS ME NEW PGE PAR UPAR WALI METHDOD KE AAGE================
	@GetMapping("/detailed-account")
	public String detailedAccount(
	        @RequestParam("id") int accountId,
	        Model model) {

	    Users user =
	        daoimpl.fetchUserWithAccountByAccountId(accountId);

	    model.addAttribute("user", user);
	    return "detailed-account";
	}
	
	//===========================================================================================
	//==========================DEPOSIT IN USER ACCOUNT FROM ADMIN PANEL=======================
	@GetMapping("/adminDeposit")
	public String adminDepositPage(HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");

	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return "signIn";
	    }
	    return "adminDeposit";
	}

	//=================================================================================
	//DEPOSITING AND FINDING ACCOUNT FROM HRE=================================
	@PostMapping("/fetchAccountForDeposit")
	public ModelAndView fetchAccountForDeposit(
	        @RequestParam String accountNo,
	        HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return new ModelAndView("signIn");
	    }

	    ModelAndView mv = new ModelAndView("adminDeposit");

	    BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);

	    // ❌ Invalid account
	    if (acc == null) {
	        mv.addObject("msg", "Invalid Account number");
	        return mv;
	    }

	    // 🔴 BLOCKED ACCOUNT CHECK
	    if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) {
	        mv.addObject("msg", "This Account is Blocked");
	        return mv;
	    }

	    // ✅ Valid + Active account
	    Users user = daoimpl.getUserByAccountNo(accountNo);

	    mv.addObject("account", acc);
	    mv.addObject("user", user);

	    return mv;
	}


//==========================================================================================
	//FINAL CONFIRM DEPOSIT=========================
	@PostMapping("/confirmDeposit")
	public String confirmDeposit(
	        @RequestParam String accountNo,
	        @RequestParam double amount,
	        HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return "redirect:/signIn";
	    }

	    // 1️⃣ Balance update
	    bankdaoimpl.addBalance(accountNo, amount);

	    // 2️⃣ Save transaction
	    Transaction txn = new Transaction();
	    txn.setFromAccount("Aashray Bank");
	    txn.setToAccount(accountNo);
	    txn.setAmount(amount);
	    txn.setMode("DEPOSIT");
	    txn.setStatus("SUCCESS");
	    txn.setReferenceId("DEP" + System.currentTimeMillis());
	    tnxdaoimpl.saveTransaction(txn);

	    // 3️⃣ Fetch user for mail
	    Users user = daoimpl.getUserByAccountNo(accountNo);

	    // 4️⃣ Send mail (NON-BLOCKING STYLE)
	    try {
	        MailUtil.sendCreditMail(
	                user.getEmail(),
	                user.getFname(),
	                amount,
	                accountNo
	        );
	    } catch (Exception e) {
	        e.printStackTrace(); // log only, deposit fail nahi hoga
	    }
	    
	    
	    session.setAttribute("receiptAccountNo", accountNo);
	    session.setAttribute("receiptAmount", amount);
	    session.setAttribute("receiptRef", txn.getReferenceId());
	    session.setAttribute("receiptDate", java.time.LocalDateTime.now());
	    session.setAttribute("receiptUser", user);

	    // 5️⃣ Flash message
	    session.setAttribute("msg", "Amount deposited successfully");

	    // 6️⃣ Redirect (IMPORTANT)
	    return "redirect:/admin-Dashboard";
	}
	//=================================================================================
	//=====================WITHDRAWL  KA KAAM HAI ...===================================
	@GetMapping("/adminWithdraw")
	public String adminWithdrawPage(HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return "redirect:/signIn";
	    }
	    return "adminWithdraw";
	}
	//=====================================================================================
	@PostMapping("/confirmWithdraw")
    public String confirmWithdraw(
            @RequestParam String accountNo,
            @RequestParam double amount,
            HttpSession session) {

        Users admin = (Users) session.getAttribute("loggedUser");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/signIn";
        }
        
     // 🔴 BLOCKED ACCOUNT SAFETY CHECK
        BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);
        if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) {
            session.setAttribute("msg", "This Account is Blocked");
            return "redirect:/adminWithdraw";
        }
        // 1️⃣ Balance check
        double currentBalance = bankdaoimpl.getBalance(accountNo);

        if (amount <= 0) {
            session.setAttribute("msg", "Invalid withdrawal amount");
            return "redirect:/adminWithdraw";
        }

        if (currentBalance < amount) {
            session.setAttribute("msg", "Insufficient balance");
            return "redirect:/adminWithdraw";
        }

        // 2️⃣ Deduct balance
        bankdaoimpl.deductBalance(accountNo, amount);

        // 3️⃣ Save transaction
        Transaction txn = new Transaction();
        txn.setFromAccount(accountNo);
        txn.setToAccount("Aashray Bank");
        txn.setAmount(amount);
        txn.setMode("WITHDRAW");
        txn.setStatus("SUCCESS");
        txn.setReferenceId("WDR" + System.currentTimeMillis());

        tnxdaoimpl.saveTransaction(txn);

        // 4️⃣ Mail
        Users user = daoimpl.getUserByAccountNo(accountNo);
        try {
            MailUtil.sendDebitMail(
                    user.getEmail(),
                    user.getFname(),
                    amount,
                    accountNo,
                    currentBalance - amount
            );
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 5️⃣ Flash message
        session.setAttribute("msg", "Amount withdrawn successfully");

        return "redirect:/admin-Dashboard";
    }

	//=====================================================================================
	@PostMapping("/fetchAccountForWithdraw")
	public ModelAndView fetchAccountForWithdraw(
	        @RequestParam String accountNo,
	        HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return new ModelAndView("redirect:/signIn");
	    }

	    ModelAndView mv = new ModelAndView("adminWithdraw");

	    BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);

	    // ❌ Invalid account
	    if (acc == null) {
	        mv.addObject("msg", "Invalid account number");
	        return mv;
	    }

	    // 🔴 BLOCKED ACCOUNT CHECK (MISSING THA)
	    if ("BLOCKED".equalsIgnoreCase(acc.getStatus())) {
	        mv.addObject("msg", "This Account is Blocked");
	        return mv;
	    }

	    // ✅ Active account
	    Users user = daoimpl.getUserByAccountNo(accountNo);

	    mv.addObject("account", acc);
	    mv.addObject("user", user);

	    return mv;
	}

//========================================================================================
	
	
	
	//==========================BLOCKING WORK========================================
	
	
	@GetMapping("/blockAllAccounts")
	public String blockAllAccounts(HttpSession session , Model model) {
	    Users admin = (Users) session.getAttribute("loggedUser");

	    if (admin == null) {
	        return "redirect:/signIn";
	    }

	    model.addAttribute("usersList", bankdaoimpl.getAllActiveUsers());
	    return "blockAllAccounts";
	}

	//========================================================================================
	@GetMapping("/blockAccount")
	public String blockAccount(@RequestParam("accId") int accId,
	                           HttpSession session) {

	    // 🔹 user accId se lao (mail ke liye)
	    Users user = bankdaoimpl.getUserByAccId(accId);

	    // 🔹 existing block logic (UNCHANGED)
	    bankdaoimpl.blockBankAccountByAccId(accId);
	    bankdaoimpl.blockUserByAccId(accId);

	    // 🔹 sirf mail send
	    MailUtil.sendAccountBlockedMail(
	        user.getEmail(),
	        user.getFname(),
	        user.getAccount().getAccountNo()
	    );

	    session.setAttribute("msg", "User Blocked successfully & mail sent");

	    return "redirect:/admin-Dashboard";
	}

	//==========================Activating WORK========================================
	@GetMapping("/ActiveAllAccounts")
	public String activeAllAccount(Model model, HttpSession session) {

	    Users admin = (Users) session.getAttribute("loggedUser");
	    if (admin == null || !"ADMIN".equals(admin.getRole())) {
	        return "signIn";
	    }

	    model.addAttribute("usersList", bankdaoimpl.getAllInactiveUsers());
	    return "ActiveAllAccounts";   //  
	}
	//====================================================================================
	@GetMapping("/activateAccount")
	public String activateAccount(@RequestParam("accId") int accId,
	                              HttpSession session) {

	    // ✅ Activate account + user
	    bankdaoimpl.activateBankAccountByAccId(accId);
	    bankdaoimpl.activateUserByAccId(accId);

	    // ✅ Fetch details for mail
	    BankAccount acc = bankdaoimpl.getAccountByAccId(accId);
	    Users user = daoimpl.getUserByAccountNo(acc.getAccountNo());

	    // ✅ Send activation mail
	    try {
	        MailUtil.sendAccountActivationMail(
	                user.getEmail(),
	                user.getFname(),
	                acc.getAccountNo()
	        );
	    } catch (Exception e) {
	        e.printStackTrace(); // mail fail ho jaye, activation safe rahe
	    }

	    session.setAttribute("msg", "Account activated successfully");
	    return "redirect:/admin-Dashboard";
	}




}
