// ================= ROW MAPPER =================
package com.bank.rowmapper;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.bank.pojo.Transaction;

public class TransactionRowMapper implements RowMapper<Transaction> {

	public TransactionRowMapper() {
		// TODO Auto-generated constructor stub
	}
        @Override
        public Transaction mapRow(ResultSet rs, int rowNum) throws SQLException {

            Transaction t = new Transaction();
            t.setId(rs.getInt("id"));
            t.setFromAccount(rs.getString("from_account"));
            t.setToAccount(rs.getString("to_account"));
            t.setAmount(rs.getDouble("amount"));
            t.setMode(rs.getString("mode"));
            t.setStatus(rs.getString("status"));
            t.setReferenceId(rs.getString("reference_id"));
            t.setCreatedAt(rs.getTimestamp("created_at"));

            return t;
        }
    }