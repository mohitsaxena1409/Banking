package com.bank.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.bank.pojo.Users;
import com.bank.pojo.BankAccount;

public class BankAccountUserRowMapper implements RowMapper<Users> {

    @Override
    public Users mapRow(ResultSet rs, int rowNum) throws SQLException {

        // ===== USERS =====
        Users u = new Users();
        u.setId(rs.getInt("id"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));
        u.setFname(rs.getString("fname"));
        u.setLname(rs.getString("lname"));
        u.setDob(rs.getDate("dob"));
        u.setGender(rs.getString("gender"));
        u.setAddress(rs.getString("address"));
        u.setCity(rs.getString("city"));
        u.setState(rs.getString("state"));
        u.setPincode(rs.getInt("pincode"));
        u.setAadharno(rs.getLong("aadharno"));
        u.setPanno(rs.getString("panno"));
        u.setPhoto(rs.getString("photo"));
        u.setSignature(rs.getString("signature"));
        u.setAadhardoc(rs.getString("aadhardoc"));
        u.setPandoc(rs.getString("pandoc"));
        u.setAccounttype(rs.getString("accounttype"));
        u.setModeofoperation(rs.getString("modeofoperation"));
        u.setAtmfacility(rs.getInt("atmfacility"));
        u.setChequebook(rs.getInt("chequebook"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setCreatedat(rs.getTimestamp("createdat"));

        // ===== BANK ACCOUNT =====
        BankAccount acc = new BankAccount();
        acc.setId(rs.getInt("acc_id"));
        acc.setAccountNo(rs.getString("account_no"));
        acc.setAccountType(rs.getString("bank_account_type"));
        acc.setOpeningBalance(rs.getDouble("opening_balance"));
        acc.setIfsc(rs.getString("ifsc"));
        acc.setBranch(rs.getString("branch"));
        acc.setAtmFacility(rs.getInt("atm_facility"));
        acc.setChequeBook(rs.getInt("cheque_book"));
        acc.setStatus(rs.getString("account_status"));

        u.setAccount(acc);

        return u;
    }
}
