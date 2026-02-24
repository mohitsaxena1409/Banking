package com.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class ViewsController {

		@RequestMapping("/")
		public String IndexPage() {
			return "index";
		}
		
		@RequestMapping("/index")
		public String IndexPageHeader() {
			return "index";
		}
		@RequestMapping("/header")
		public String headerPage() {
			return "header";
		}
		
		@RequestMapping("/registration")
		public String registrationPage() {
			return "registration";
		}
		
		@RequestMapping("/404")
		public String Four0FourPage() {
			return "404";
		}
		
		@RequestMapping("/about")
		public String aboutPage() {
			return "about";
		}
		
		@RequestMapping("/contact")
		public String contactPage() {
			return "contact";
		}
		
		@RequestMapping("/feature")
		public String featurePage() {
			return "feature";
		}
		
		@RequestMapping("/service")
		public String servicePage() {
			return "service";
		}
				
		@RequestMapping("/testimonial")
		public String testimonialPage() {
			return "testimonial";
		}
		
		@RequestMapping("/signIn")
		public String signInPage() {
			return "signIn";
		}
		
		@RequestMapping("/signUp")
		public String signUpPage() {
			return "signUp";
		}
		
		@RequestMapping("/user-Dashboard")
		public String userDashboardPage() {
			return "user-Dashboard";
		}
		
		@RequestMapping("/update-profile")
		public String updateprofilePage() {
			return "update-profile";
		}
		
		@RequestMapping("/view-transactions")
		public String viewTransactionPage() {
			return "view-transactions";
		}
		
		@GetMapping("/transfer-money")
		public String transferForm() {
		    return "transfer-money";
		}
		
		@GetMapping("/add-user")
		public String addUser() {
		    return "add-user";
		}
		@GetMapping("/addMoney")
		public String addMoney() {
		    return "addMoney";
		}
		
		

}
