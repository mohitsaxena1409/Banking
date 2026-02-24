package com.bank.pojo;

import java.sql.Timestamp;

public class Transaction {

    private int id;
    private String fromAccount;
    private String toAccount;
    private double amount;
    private String mode;
    private String status;
    private String referenceId;
    private Timestamp createdAt;
    //===== Constructors =====
    
    public Transaction() {
		// TODO Auto-generated constructor stub
	}
    
    
    // ===== Getters & Setters =====

    public Transaction(int id, String fromAccount, String toAccount, double amount, String mode, String status,
			String referenceId, Timestamp createdAt) {
		super();
		this.id = id;
		this.fromAccount = fromAccount;
		this.toAccount = toAccount;
		this.amount = amount;
		this.mode = mode;
		this.status = status;
		this.referenceId = referenceId;
		this.createdAt = createdAt;
	}


	public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getFromAccount() {
        return fromAccount;
    }
    public void setFromAccount(String fromAccount) {
        this.fromAccount = fromAccount;
    }

    public String getToAccount() {
        return toAccount;
    }
    public void setToAccount(String toAccount) {
        this.toAccount = toAccount;
    }

    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getMode() {
        return mode;
    }
    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getReferenceId() {
        return referenceId;
    }
    public void setReferenceId(String referenceId) {
        this.referenceId = referenceId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }


	@Override
	public String toString() {
		return "Transaction [id=" + id + ", fromAccount=" + fromAccount + ", toAccount=" + toAccount + ", amount="
				+ amount + ", mode=" + mode + ", status=" + status + ", referenceId=" + referenceId + ", createdAt="
				+ createdAt + "]";
	}
    
    
}
