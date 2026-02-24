package com.bank.dao;

import java.util.List;
import com.bank.pojo.Transaction;

public interface TransactionDao {
	
    void saveTransaction(Transaction txn);
    
    //specific user ke liye 
    List<Transaction> getTransactionsByAccount(String accountNo);
    
    //sabke liye 
    public List<Transaction> getTransactions();
    
}
