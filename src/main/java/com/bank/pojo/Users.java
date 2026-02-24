package com.bank.pojo;

import java.sql.Date;
import java.sql.Timestamp;

public class Users {

	// PRIMARY KEY
    private int id;

    // LOGIN IDENTIFIER
    private String email;
    private String phone;
    private String role;      // USER / ADMIN
    private String status;    // PENDING / ACTIVE / REJECTED

    // PERSONAL DETAILS
    private String fname;
    private String lname;
    private Date dob;
    private String gender;

    // ADDRESS DETAILS
    private String address;
    private String city;
    private String state;
    private int pincode;          // ✅ numeric

    // KYC DETAILS
    private long aadharno;        // ✅ 12–14 digit safe
    private String panno;
    private String photo;
    private String signature;

    // DOCUMENT FILES
    private String aadhardoc;
    private String pandoc;

    // ACCOUNT PREFERENCES
    private String accounttype;
    private String modeofoperation;
    private int atmfacility;      // 1 = Yes, 0 = No
    private int chequebook;       // 1 = Yes, 0 = No

    private String username;
    private String password;
    
    // META
    private Timestamp createdat;
   
    public Users() {
		super();
		// TODO Auto-generated constructor stub
	}
    
	public Users(int id, String email, String phone, String role, String status, String fname, String lname, Date dob,
			String gender, String address, String city, String state, int pincode, long aadharno, String panno,
			String photo, String signature, String aadhardoc, String pandoc, String accounttype, String modeofoperation,
			int atmfacility, int chequebook, String username, String password, Timestamp createdat) {
		super();
		this.id = id;
		this.email = email;
		this.phone = phone;
		this.role = role;
		this.status = status;
		this.fname = fname;
		this.lname = lname;
		this.dob = dob;
		this.gender = gender;
		this.address = address;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
		this.aadharno = aadharno;
		this.panno = panno;
		this.photo = photo;
		this.signature = signature;
		this.aadhardoc = aadhardoc;
		this.pandoc = pandoc;
		this.accounttype = accounttype;
		this.modeofoperation = modeofoperation;
		this.atmfacility = atmfacility;
		this.chequebook = chequebook;
		this.username = username;
		this.password = password;
		this.createdat = createdat;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getPincode() {
		return pincode;
	}
	public void setPincode(int pincode) {
		this.pincode = pincode;
	}
	public long getAadharno() {
		return aadharno;
	}
	public void setAadharno(long aadharno) {
		this.aadharno = aadharno;
	}
	public String getPanno() {
		return panno;
	}
	public void setPanno(String panno) {
		this.panno = panno;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getAadhardoc() {
		return aadhardoc;
	}
	public void setAadhardoc(String aadhardoc) {
		this.aadhardoc = aadhardoc;
	}
	public String getPandoc() {
		return pandoc;
	}
	public void setPandoc(String pandoc) {
		this.pandoc = pandoc;
	}
	public String getAccounttype() {
		return accounttype;
	}
	public void setAccounttype(String accounttype) {
		this.accounttype = accounttype;
	}
	public String getModeofoperation() {
		return modeofoperation;
	}
	public void setModeofoperation(String modeofoperation) {
		this.modeofoperation = modeofoperation;
	}
	public int getAtmfacility() {
		return atmfacility;
	}
	public void setAtmfacility(int atmfacility) {
		this.atmfacility = atmfacility;
	}
	public int getChequebook() {
		return chequebook;
	}
	public void setChequebook(int chequebook) {
		this.chequebook = chequebook;
	}
	public Timestamp getCreatedat() {
		return createdat;
	}
	public void setCreatedat(Timestamp createdat) {
		this.createdat = createdat;
	}
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "Users [id=" + id + ", email=" + email + ", phone=" + phone + ", role=" + role + ", status=" + status
				+ ", fname=" + fname + ", lname=" + lname + ", dob=" + dob + ", gender=" + gender + ", address="
				+ address + ", city=" + city + ", state=" + state + ", pincode=" + pincode + ", aadharno=" + aadharno
				+ ", panno=" + panno + ", photo=" + photo + ", signature=" + signature + ", aadhardoc=" + aadhardoc
				+ ", pandoc=" + pandoc + ", accounttype=" + accounttype + ", modeofoperation=" + modeofoperation
				+ ", atmfacility=" + atmfacility + ", chequebook=" + chequebook + ", username=" + username
				+ ", password=" + password + ", createdat=" + createdat + "]";
	}
	private BankAccount account;

    public BankAccount getAccount() {
        return account;
    }

    public void setAccount(BankAccount account) {
        this.account = account;
    }
	
}
