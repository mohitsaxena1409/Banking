package com.bank.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.bank.pojo.BankAccount;

public class BankAccountRowMapper implements RowMapper<BankAccount> {

    @Override
    public BankAccount mapRow(ResultSet rs, int rowNum) throws SQLException {

        BankAccount b = new BankAccount();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setAccountNo(rs.getString("account_no"));
        b.setIfsc(rs.getString("ifsc"));
        b.setBranch(rs.getString("branch"));
        b.setAccountType(rs.getString("account_type"));
        b.setOpeningBalance(rs.getDouble("opening_balance"));
        b.setStatus(rs.getString("status"));

        return b;
    }
}
