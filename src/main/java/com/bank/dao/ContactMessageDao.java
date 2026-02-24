package com.bank.dao;

import java.util.List;

import com.bank.pojo.ContactMessage;

public interface ContactMessageDao {

    boolean saveMessage(ContactMessage msg);

    List<ContactMessage> getAllMessages();

    boolean deleteMessage(int id);

    boolean updateStatus(int id, String status);
}

