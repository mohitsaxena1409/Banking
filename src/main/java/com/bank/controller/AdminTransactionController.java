package com.bank.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bank.daoimpl.BankAccountDaoImpl;
import com.bank.daoimpl.TransactionDaoImpl;
import com.bank.daoimpl.UsersDaoImpl;
import com.bank.pojo.BankAccount;
import com.bank.pojo.Transaction;
import com.bank.pojo.Users;
import com.bank.service.BankTransactionService;

@Controller
public class AdminTransactionController {
	
	    @Autowired
	    private TransactionDaoImpl tnxdaoimpl;
	    
	    @Autowired
	    private UsersDaoImpl daoimpl;
		
		@Autowired
	    private BankAccountDaoImpl bankdaoimpl;

	    @GetMapping("/transactionsadminpanel")
	    public String adminTransactions(HttpServletRequest request) {

	        // 🔥 BUSINESS LOGIC CALL
	        List<Transaction> txList =
	                tnxdaoimpl.getTransactions();

	        // JSP ko data bhejna
	        request.setAttribute("txList", txList);

	        // JSP page name (view resolver handle karega)
	        return "transactionsadminpanel";
	    }
	    
	    //======================SEARCH===================================
	    @GetMapping("/adminAccountTransactions")
	    public ModelAndView adminAccountTransactions(
	            @RequestParam String accountNo,
	            HttpSession session) {

	        BankAccount acc = bankdaoimpl.getAccountByAccountNo(accountNo);
	        Users user = bankdaoimpl.getUserByAccId(acc.getId());

	        List<Transaction> list =
	            tnxdaoimpl.getTransactionsByAccount(accountNo);

	        ModelAndView mv = new ModelAndView("admin-user-actions");
	        mv.addObject("account", acc);
	        mv.addObject("user", user);
	        mv.addObject("txList", list);

	        return mv;
	    }

	}



