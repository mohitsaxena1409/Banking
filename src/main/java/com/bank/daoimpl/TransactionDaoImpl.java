package com.bank.daoimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.bank.dao.TransactionDao;
import com.bank.pojo.Transaction;
import com.bank.rowmapper.TransactionRowMapper;

@Repository
public class TransactionDaoImpl implements TransactionDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // ================= SAVE TRANSACTION =================
    @Override
    public void saveTransaction(Transaction txn) {

        String sql = "INSERT INTO transactions "
                   + "(from_account, to_account, amount, mode, status, reference_id) "
                   + "VALUES (?,?,?,?,?,?)";

        jdbcTemplate.update(
            sql,
            txn.getFromAccount(),
            txn.getToAccount(),
            txn.getAmount(),
            txn.getMode(),
            txn.getStatus(),
            txn.getReferenceId()
        );
    }

    // ================= FETCH TRANSACTIONS FOR SPECIFI USER PANEL  =================
    @Override
    public List<Transaction> getTransactionsByAccount(String accountNo) {

        String sql = "SELECT * FROM transactions "
                   + "WHERE from_account = ? OR to_account = ? "
                   + "ORDER BY created_at DESC";

        return jdbcTemplate.query(
            sql,
            new Object[]{ accountNo, accountNo }, // 👈 dono jagah same accountNo
            new TransactionRowMapper()
        );
    }

    
 // ================= FETCH TRANSACTIONS FROM ADMIN PANEL  =================
    @Override
    public List<Transaction> getTransactions() {

        String sql =
            "SELECT * FROM transactions ORDER BY created_at DESC";

        return jdbcTemplate.query(
            sql,
            new TransactionRowMapper()
        );
    }


    
}
