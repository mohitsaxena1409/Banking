package com.bank.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import com.bank.pojo.Users;

public class UsersRowMapper implements RowMapper<Users> {

    @Override
    public Users mapRow(ResultSet rs, int rowNum) throws SQLException {

        Users u = new Users();

        u.setId(rs.getInt("id"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));

        u.setFname(rs.getString("fname"));
        u.setLname(rs.getString("lname"));
        u.setDob(rs.getDate("dob"));
        u.setGender(rs.getString("gender"));

        u.setAddress(rs.getString("address"));
        u.setCity(rs.getString("city"));
        u.setState(rs.getString("state"));
        u.setPincode(rs.getInt("pincode"));

        u.setAadharno(rs.getLong("aadharno"));
        u.setPanno(rs.getString("panno"));
        u.setPhoto(rs.getString("photo"));
        u.setSignature(rs.getString("signature"));

        u.setAadhardoc(rs.getString("aadhardoc"));
        u.setPandoc(rs.getString("pandoc"));

        u.setAccounttype(rs.getString("accounttype"));
        u.setModeofoperation(rs.getString("modeofoperation"));
        u.setAtmfacility(rs.getInt("atmfacility"));
        u.setChequebook(rs.getInt("chequebook"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));

        u.setCreatedat(rs.getTimestamp("createdat"));

        return u;
    }
}
