package com.bank.pojo;

public class BankAccount {

	private int id;
    private int userId;
    private String accountNo;
    private String ifsc;
    private String branch;
    private String accountType;
    private double openingBalance;
    private int atmFacility;
    private int chequeBook;
    private String status;
    
    public BankAccount() {
		super();
	}

	public BankAccount(int id, int userId, String accountNo, String ifsc, String branch, String accountType,
			double openingBalance, int atmFacility, int chequeBook, String status) {
		super();
		this.id = id;
		this.userId = userId;
		this.accountNo = accountNo;
		this.ifsc = ifsc;
		this.branch = branch;
		this.accountType = accountType;
		this.openingBalance = openingBalance;
		this.atmFacility = atmFacility;
		this.chequeBook = chequeBook;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getIfsc() {
		return ifsc;
	}

	public void setIfsc(String ifsc) {
		this.ifsc = ifsc;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public double getOpeningBalance() {
		return openingBalance;
	}

	public void setOpeningBalance(double openingBalance) {
		this.openingBalance = openingBalance;
	}

	public int getAtmFacility() {
		return atmFacility;
	}

	public void setAtmFacility(int atmFacility) {
		this.atmFacility = atmFacility;
	}

	public int getChequeBook() {
		return chequeBook;
	}

	public void setChequeBook(int chequeBook) {
		this.chequeBook = chequeBook;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
    
    
    
}
