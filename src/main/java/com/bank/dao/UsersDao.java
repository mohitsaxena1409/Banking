package com.bank.dao;

import java.util.List;
import com.bank.pojo.Users;

public interface UsersDao {

    int saveUser(Users user);
    Users checkUser(String username, String password);
    Users getUserById(int id);
    List<Users> getPendingUsers();
    int updateStatus(int id, String status);
    List<Users> getAllUsers();
    Users getUserByAccountNo(String accountNo);
    public Users fetchUserWithAccountByAccountId(int accountId);
}
