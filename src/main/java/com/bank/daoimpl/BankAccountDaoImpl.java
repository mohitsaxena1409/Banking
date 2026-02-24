package com.bank.daoimpl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bank.dao.BankAccountDao;
import com.bank.pojo.BankAccount;
import com.bank.pojo.Transaction;
import com.bank.pojo.Users;
import com.bank.rowmapper.BankAccountRowMapper;
import com.bank.rowmapper.BankAccountUserRowMapper;
import com.bank.util.MailUtil;

@Repository
public class BankAccountDaoImpl implements BankAccountDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    

    // ======================================================================
    // GET ACCOUNT BY USER ID
    @Override
    public BankAccount getAccountByUserId(int userId) {

        String sql = "SELECT * FROM bank_account WHERE user_id=?";

        try {
            return jdbcTemplate.queryForObject(
                sql,
                new BankAccountRowMapper(),
                userId
            );
        } catch (Exception e) {
            return null; // account not activated yet
        }
    }

    // ======================================================================
    // 1️⃣ GET ACCOUNT BY ACCOUNT NUMBER
    @Override
    public BankAccount getAccountByAccountNo(String accountNo) {

        String sql = "SELECT * FROM bank_account WHERE account_no=?";

        try {
            return jdbcTemplate.queryForObject(
                sql,
                new BankAccountRowMapper(),
                accountNo
            );
        } catch (Exception e) {
            return null;
        }
    }

    // ======================================================================
    // 2️⃣ DEDUCT BALANCE (Sender se paisa ghatana)
    @Override
    public void deductBalance(String accountNo, double amount) {

        String sql =
            "UPDATE bank_account " +
            "SET opening_balance = opening_balance - ? " +
            "WHERE account_no=?";

        jdbcTemplate.update(sql, amount, accountNo);
    }

    // ======================================================================
    // 3️⃣ ADD BALANCE (Receiver ko paisa dena / Deposit)
    @Override
    public void addBalance(String accountNo, double amount) {

        String sql =
            "UPDATE bank_account " +
            "SET opening_balance = opening_balance + ? " +
            "WHERE account_no=?";

        jdbcTemplate.update(sql, amount, accountNo);
    }

    // ======================================================================
    // 4️⃣ CHECK ACCOUNT EXISTS (Optional but safe)
    @Override
    public boolean isAccountExists(String accountNo) {

        String sql =
            "SELECT COUNT(*) FROM bank_account WHERE account_no=?";

        Integer count = jdbcTemplate.queryForObject(
            sql,
            Integer.class,
            accountNo
        );

        return count != null && count > 0;
    }
    //================================================================================
    //DEDUCTION FROM ADMIN PANEL........................
    public double getBalance(String accountNo) {
        String sql = "SELECT opening_balance FROM bank_account WHERE account_no=?";
        return jdbcTemplate.queryForObject(sql, Double.class, accountNo);
    }
    //==================================================================================
    public void blockBankAccountByAccId(int accId) {
        String sql =
          "UPDATE bank_account SET status='BLOCKED' WHERE id=?";
        jdbcTemplate.update(sql, accId);
    }
    //==================+====================================================================
    public void blockUserByAccId(int accId) {
        String sql =
          "UPDATE users SET status='BLOCKED' " +
          "WHERE id = (SELECT user_id FROM bank_account WHERE id=?)";
        jdbcTemplate.update(sql, accId);
    }
    //==========================================================================
    public List<Users> getAllActiveUsers() {

        String sql =
            "SELECT u.id AS user_id, u.fname, u.lname, u.email, u.phone, u.status AS user_status, " +
            "b.id AS acc_id, b.account_no, b.account_type, b.opening_balance, b.status AS acc_status " +
            "FROM users u " +
            "JOIN bank_account b ON u.id = b.user_id " +
            "WHERE b.status = 'ACTIVE'";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {

            Users u = new Users();
            u.setId(rs.getInt("user_id"));
            u.setFname(rs.getString("fname"));
            u.setLname(rs.getString("lname"));
            u.setEmail(rs.getString("email"));
            u.setPhone(rs.getString("phone"));
            u.setStatus(rs.getString("user_status"));

            BankAccount acc = new BankAccount();
            acc.setId(rs.getInt("acc_id"));
            acc.setAccountNo(rs.getString("account_no"));
            acc.setAccountType(rs.getString("account_type"));
            acc.setOpeningBalance(rs.getDouble("opening_balance"));
            acc.setStatus(rs.getString("acc_status"));

            u.setAccount(acc);   // 🔴 JSP yahin se acc le raha hai

            return u;
        });
    }
    //=================================================================
    
 // =========================================================
 // GET USER BY ACCOUNT ID (for block mail)
 // =========================================================
 public Users getUserByAccId(int accId) {

     String sql =
         "SELECT u.id, u.fname, u.lname, u.email, u.phone, u.status, " +
         "b.account_no " +
         "FROM users u " +
         "JOIN bank_account b ON u.id = b.user_id " +
         "WHERE b.id = ?";

     return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {

         Users u = new Users();
         u.setId(rs.getInt("id"));
         u.setFname(rs.getString("fname"));
         u.setLname(rs.getString("lname"));
         u.setEmail(rs.getString("email"));
         u.setPhone(rs.getString("phone"));
         u.setStatus(rs.getString("status"));

         BankAccount acc = new BankAccount();
         acc.setAccountNo(rs.getString("account_no"));

         u.setAccount(acc);

         return u;
     }, accId);
 }
 //====================================================================================
//=========================================================
//CHECK ACCOUNT STATUS BY ACCOUNT ID
//=========================================================
public String getAccountStatusByAccId(int accId) {

  String sql = "SELECT status FROM bank_account WHERE id=?";

  return jdbcTemplate.queryForObject(sql, String.class, accId);
}
//======================================================================================
//==========================ACTIVATING ACCOUNT KA KAAM======================================
public List<Users> getAllInactiveUsers() {

    String sql =
        "SELECT u.id AS user_id, u.fname, u.lname, u.email, u.phone, u.status AS user_status, " +
        "b.id AS acc_id, b.account_no, b.account_type, b.opening_balance, b.status AS acc_status " +
        "FROM users u " +
        "JOIN bank_account b ON u.id = b.user_id " +
        "WHERE b.status = 'BLOCKED'";

    return jdbcTemplate.query(sql, (rs, rowNum) -> {

        Users u = new Users();
        u.setId(rs.getInt("user_id"));
        u.setFname(rs.getString("fname"));
        u.setLname(rs.getString("lname"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setStatus(rs.getString("user_status"));

        BankAccount acc = new BankAccount();
        acc.setId(rs.getInt("acc_id"));
        acc.setAccountNo(rs.getString("account_no"));
        acc.setAccountType(rs.getString("account_type"));
        acc.setOpeningBalance(rs.getDouble("opening_balance"));
        acc.setStatus(rs.getString("acc_status"));

        u.setAccount(acc);

        return u;
    });
}
//========================================METHODS==================================
public void activateBankAccountByAccId(int accId) {
    String sql = "UPDATE bank_account SET status='ACTIVE' WHERE id=?";
    jdbcTemplate.update(sql, accId);
}

public void activateUserByAccId(int accId) {
    String sql =
      "UPDATE users SET status='ACTIVE' " +
      "WHERE id = (SELECT user_id FROM bank_account WHERE id=?)";
    jdbcTemplate.update(sql, accId);
}
//================================================================================
public BankAccount getAccountByAccId(int accId) {

    String sql = "SELECT * FROM bank_account WHERE id = ?";

    return jdbcTemplate.queryForObject(
        sql,
        new Object[]{accId},
        (rs, rowNum) -> {

            BankAccount acc = new BankAccount();
            acc.setId(rs.getInt("id"));
            acc.setAccountNo(rs.getString("account_no"));
            acc.setAccountType(rs.getString("account_type"));
            acc.setOpeningBalance(rs.getDouble("opening_balance"));
            acc.setStatus(rs.getString("status"));

            return acc;
        }
    );
}
//================================SEARCH ==================================

public void updateAccount(BankAccount acc) {

    String sql =
        "UPDATE bank_account SET opening_balance=? WHERE account_no=?";

    jdbcTemplate.update(
        sql,
        acc.getOpeningBalance(),
        acc.getAccountNo()
    );
}




    
}
