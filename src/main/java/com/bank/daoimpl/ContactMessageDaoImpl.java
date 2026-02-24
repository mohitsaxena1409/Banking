package com.bank.daoimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bank.dao.ContactMessageDao;
import com.bank.pojo.ContactMessage;

@Repository
public class ContactMessageDaoImpl implements ContactMessageDao {

    @Autowired
    private JdbcTemplate jdbc;

    @Override
    public boolean saveMessage(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages(name,email,mobile,subject,message) VALUES(?,?,?,?,?)";
        return jdbc.update(sql,
                msg.getName(),
                msg.getEmail(),
                msg.getMobile(),
                msg.getSubject(),
                msg.getMessage()) > 0;
    }

    @Override
    public List<ContactMessage> getAllMessages() {
        return jdbc.query("SELECT * FROM contact_messages ORDER BY id DESC",
            new BeanPropertyRowMapper<>(ContactMessage.class));
    }

    @Override
    public boolean deleteMessage(int id) {
        return jdbc.update("DELETE FROM contact_messages WHERE id=?", id) > 0;
    }

    @Override
    public boolean updateStatus(int id, String status) {
        return jdbc.update("UPDATE contact_messages SET status=? WHERE id=?", status, id) > 0;
    }
    
    public ContactMessage getMessageById(int id) {
        String sql = "SELECT * FROM contact_messages WHERE id=?";
        return jdbc.queryForObject(
                sql,
                new BeanPropertyRowMapper<>(ContactMessage.class),
                id
        );
    }

}
