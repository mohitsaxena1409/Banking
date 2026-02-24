package com.bank.pojo;

import java.sql.Timestamp;

public class ContactMessage {

    private int id;
    private String name;
    private String email;
    private String mobile;
    private String subject;
    private String message;
    private String status;
    private Timestamp createdAt;

    // getters & setters
    
    public ContactMessage() {
		// TODO Auto-generated constructor stub
	}

	public ContactMessage(int id, String name, String email, String mobile, String subject, String message,
			String status, Timestamp createdAt) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.subject = subject;
		this.message = message;
		this.status = status;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "ContactMessage [id=" + id + ", name=" + name + ", email=" + email + ", mobile=" + mobile + ", subject="
				+ subject + ", message=" + message + ", status=" + status + ", createdAt=" + createdAt + "]";
	}
    
}
