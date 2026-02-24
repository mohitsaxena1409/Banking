package com.bank.dao;

import java.util.List;

import com.bank.pojo.BankAccount;
import com.bank.pojo.Users;

public interface BankAccountDao {

    // Already existing
    BankAccount getAccountByUserId(int userId);

    // =====================================================
    // TRANSFER / DEPOSIT / WITHDRAW SUPPORT METHODS

    // 1️⃣ Account number se account lao
    BankAccount getAccountByAccountNo(String accountNo);

    // 2️⃣ Sender se balance minus
    void deductBalance(String accountNo, double amount);

    // 3️⃣ Receiver / Deposit me balance add
    void addBalance(String accountNo, double amount);

    // 4️⃣ Account exists check
    boolean isAccountExists(String accountNo);
    
    
    
}
