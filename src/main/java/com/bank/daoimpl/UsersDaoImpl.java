package com.bank.daoimpl;
	
import java.util.ArrayList;
import java.util.List;
	
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bank.dao.UsersDao;
import com.bank.pojo.Users;
import com.bank.rowmapper.BankAccountUserRowMapper;
import com.bank.rowmapper.UsersRequestRowMapper;
	import com.bank.rowmapper.UsersRowMapper;
	
	@Repository
	public class UsersDaoImpl implements UsersDao {
	
	    @Autowired
	    private JdbcTemplate jdbcTemplate;
	    //========================================================================================================
	    @Override
	    public int saveUser(Users u) {
	
	        String sql = """
	            INSERT INTO users_request
	            (fname, lname, dob, gender,
	             phone, email,
	             address, city, state, pincode,
	             aadharno, panno,
	             photo, signature, aadhardoc, pandoc,
	             accounttype, modeofoperation,
	             atmfacility, chequebook,
	             role, status)
	            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
	        """;
	
	        return jdbcTemplate.update(sql,
	                u.getFname(),
	                u.getLname(),
	                u.getDob(),
	                u.getGender(),
	
	                u.getPhone(),
	                u.getEmail(),
	
	                u.getAddress(),
	                u.getCity(),
	                u.getState(),
	                u.getPincode(),
	
	                u.getAadharno(),
	                u.getPanno(),
	
	                u.getPhoto(),
	                u.getSignature(),
	                u.getAadhardoc(),
	                u.getPandoc(),
	
	                u.getAccounttype(),
	                u.getModeofoperation(),
	                u.getAtmfacility(),
	                u.getChequebook(),
	
	                u.getRole(),
	                u.getStatus()
	        );
	    }
	
	    //========================================================================================================
	    // LOGIN CHECK (ADMIN + USER)
	    @Override
	    public Users checkUser(String username, String password) {
	
	        String sql =
	          "SELECT * FROM users WHERE  username=? AND password=?";
	
	        try {
	            Users u1= jdbcTemplate.queryForObject(
	                    sql,
	                    new UsersRowMapper(),
	                    username,
	                    password
	            );
	            if(u1!=null)
	            		return u1;
	            else
	            		return null;
	        } catch (Exception e) {
	            return null;
	        }
	    }
	
	//=================================================================================================
	    // GET USER BY ID
	    @Override
	    public Users getUserById(int id) {
	
	        String sql = "SELECT * FROM users_request WHERE id=?";
	
	        return jdbcTemplate.queryForObject(
	                sql,
	                new UsersRowMapper(),
	                id
	        );
	    }
	 //===============================================================================================//
	
	    // ADMIN: VIEW PENDING USERS
	    @Override
	    public List<Users> getPendingUsers() {
	
	        String sql =
	          "SELECT * FROM users_request WHERE status='PENDING'";
	
	        return jdbcTemplate.query(sql, new UsersRequestRowMapper());
	    }
	//===============================================================================================//
	    // ADMIN: APPROVE / REJECT USER
	    @Override
	    public int updateStatus(int id, String status) {
	        String sql = "UPDATE users_request SET status=? WHERE id=?";
	        return jdbcTemplate.update(sql, status, id);
	    }
	    
	    //======================================================================================
	    
	    //========================================================================================================
	    @Override
	    public List<Users> getAllUsers() {
	
	            String sql = "SELECT * from users";
	            return jdbcTemplate.query(sql, new UsersRequestRowMapper());
	        }
	    
	    //========================================================================================================
	    
	    //YAHA PAR FINAL BANK TABLE ME JAYEGA DATA AUR USER COMPLETELY REGISTER HOGA....
	    public String finalApproveUser(
	            int requestId,
	            String accountNo,
	            String ifsc,
	            String branch,
	            double openingBalance,
	            String username,
	            String password) {
	
	        String msg = "";   // 👈 SINGLE MESSAGE VARIABLE
	
	        try {
	            // ✅ CHECK: request exists or not
	            Integer count = jdbcTemplate.queryForObject(
	                "SELECT COUNT(*) FROM users_request WHERE id=?",
	                Integer.class,
	                requestId
	            );
	
	            if (count == null || count == 0) {
	                msg = "User already approved or request not found";
	                return msg;
	            }
	
	            // 1️⃣ Fetch user
	            Users u = jdbcTemplate.queryForObject(
	                "SELECT * FROM users_request WHERE id=?",
	                new UsersRowMapper(),
	                requestId
	            );
	
	            // 2️⃣ Insert into USERS
	            String userSql = """
	                INSERT INTO users
	                (email, phone, role, status,
	                 fname, lname, dob, gender,
	                 address, city, state, pincode,
	                 aadharno, panno,
	                 photo, signature, aadhardoc, pandoc,
	                 accounttype, modeofoperation,
	                 atmfacility, chequebook,
	                 username, password)
	                VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
	            """;
	
	            jdbcTemplate.update(userSql,
	                u.getEmail(),
	                u.getPhone(),
	                "CUSTOMER",
	                "ACTIVE",
	                u.getFname(),
	                u.getLname(),
	                u.getDob(),
	                u.getGender(),
	                u.getAddress(),
	                u.getCity(),
	                u.getState(),
	                u.getPincode(),
	                u.getAadharno(),
	                u.getPanno(),
	                u.getPhoto(),
	                u.getSignature(),
	                u.getAadhardoc(),
	                u.getPandoc(),
	                u.getAccounttype(),
	                u.getModeofoperation(),
	                u.getAtmfacility(),
	                u.getChequebook(),
	                username,
	                password
	            );
	
	            // 3️⃣ Get user id
	            Integer userId = jdbcTemplate.queryForObject(
	                "SELECT id FROM users WHERE username=?",
	                Integer.class,
	                username
	            );
	
	            // 4️⃣ Insert bank account
	            String bankSql = """
	                INSERT INTO bank_account
	                (user_id, account_no, ifsc, branch,
	                 account_type, opening_balance,
	                 atm_facility, cheque_book, status)
	                VALUES (?,?,?,?,?,?,?,?,?)
	            """;
	
	            jdbcTemplate.update(bankSql,
	                userId,
	                accountNo,
	                ifsc,
	                branch,
	                u.getAccounttype(),
	                openingBalance,
	                u.getAtmfacility(),
	                u.getChequebook(),
	                "ACTIVE"
	            );
	
	            // 5️⃣ Delete request
	            jdbcTemplate.update(
	                "DELETE FROM users_request WHERE id=?",
	                requestId
	            );
	
	            msg = "User approved successfully";
	
	        } catch (Exception e) {
	            e.printStackTrace();
	            msg = "Error while approving user : " + e.getMessage();  // 👈 EXCEPTION MSG
	        }
	
	        return msg;   // 👈 ALWAYS RETURN MSG
	    }
	    //============================================================================================
	  //UPDATE USERNAME AND PASSWORD FROM USER.
	    public int updateProfile(
	            int userId,
	            String username,
	            String password,
	            String photo) {
	
	        String sql =
	            "UPDATE users SET username=?, password=?, photo=? WHERE id=?";
	
	        return jdbcTemplate.update(
	                sql,
	                username,
	                password,
	                photo,
	                userId
	        );
	    }
	//==============================================================================
	 // ================= AADHAR UNIQUE CHECK =================
	    public boolean isAadharExists(long aadharno) {
	        Integer count = jdbcTemplate.queryForObject(
	            "SELECT COUNT(*) FROM users_request WHERE aadharno=?",
	            Integer.class,
	            aadharno
	        );

	        Integer count2 = jdbcTemplate.queryForObject(
	            "SELECT COUNT(*) FROM users WHERE aadharno=?",
	            Integer.class,
	            aadharno
	        );

	        return (count != null && count > 0) || (count2 != null && count2 > 0);
	    }

	    // ================= PAN UNIQUE CHECK =================
	    public boolean isPanExists(String panno) {
	        Integer count = jdbcTemplate.queryForObject(
	            "SELECT COUNT(*) FROM users_request WHERE panno=?",
	            Integer.class,
	            panno
	        );

	        Integer count2 = jdbcTemplate.queryForObject(
	            "SELECT COUNT(*) FROM users WHERE panno=?",
	            Integer.class,
	            panno
	        );

	        return (count != null && count > 0) || (count2 != null && count2 > 0);
	    }
	    //==========================Bank table me is laa rhe hai=====================
	    @Override
	    public Users getUserByAccountNo(String accountNo) {

	    	String sql =
	    		    "SELECT u.*, b.opening_balance " +
	    		    "FROM users u " +
	    		    "JOIN bank_account b ON u.id = b.user_id " +
	    		    "WHERE b.account_no = ?";


	        try {
	            return jdbcTemplate.queryForObject(
	                sql,
	                new UsersRowMapper(),
	                accountNo
	            );
	        } catch (Exception e) {
	            return null;
	        }
	    }

	//====SAARA DATA (USERS KA AUR BANK KA ADMIN PANEL ME SHOW KRNE KE LIYE)==============
	    public List<Users> fetchAllUsersWithAccounts() {

	        String sql =
	            "SELECT u.*, " +
	            "a.id AS acc_id, " +
	            "a.account_no, " +
	            "a.account_type AS bank_account_type, " +
	            "a.opening_balance, " +
	            "a.ifsc, " +
	            "a.branch, " +
	            "a.atm_facility, " +
	            "a.cheque_book, " +
	            "a.status AS account_status, " +
	            "a.created_at AS account_created_at " +
	            "FROM users u " +
	            "JOIN bank_account a ON u.id = a.user_id";

	        return jdbcTemplate.query(
	                sql,
	                new BankAccountUserRowMapper()
	        );
	    }
	    //==========================================================================================
	    @Override
	    public Users fetchUserWithAccountByAccountId(int accountId) {

	        String sql =
	            "SELECT u.*, " +
	            "a.id AS acc_id, " +
	            "a.account_no, " +
	            "a.account_type AS bank_account_type, " +
	            "a.opening_balance, " +
	            "a.ifsc, " +
	            "a.branch, " +
	            "a.atm_facility, " +
	            "a.cheque_book, " +
	            "a.status AS account_status, " +
	            "a.created_at AS account_created_at " +
	            "FROM users u " +
	            "JOIN bank_account a ON u.id = a.user_id " +
	            "WHERE a.id = ?";

	        return jdbcTemplate.queryForObject(
	                sql,
	                new BankAccountUserRowMapper(),
	                accountId
	        );
	    }
//==========================================================================================
	    public List<Users> getActiveUsers() {
	    	String sql = "SELECT * FROM users WHERE status=? AND role=?";
	    	return jdbcTemplate.query(sql, new UsersRowMapper(), "ACTIVE", "CUSTOMER");


	    }
//======================================================================================= 
	    public int updatePersonalAddress(Users u) {

	        String sql = """
	            UPDATE users SET
	            fname=?, lname=?, dob=?, gender=?,
	            phone=?, address=?, city=?, state=?, pincode=?
	            WHERE id=?
	            """;

	        return jdbcTemplate.update(sql,
	            u.getFname(),
	            u.getLname(),
	            u.getDob(),
	            u.getGender(),
	            u.getPhone(),
	            u.getAddress(),
	            u.getCity(),
	            u.getState(),
	            u.getPincode(),
	            u.getId()
	        );
	    }


//========================================================================================
	    public Users getActiveUserById(int id) {
	        String sql = "SELECT * FROM users WHERE id=?";
	        return jdbcTemplate.queryForObject(
	            sql,
	            new UsersRowMapper(),
	            id
	        );
	    }
//==========================================================================================
	    
	}
