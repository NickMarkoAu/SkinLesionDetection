/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.skindeep.db;

import utils.OzDate;
import utils.Db;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author nickm_000
 */
public class User {

    public String userName, passHash, firstName, surName, email, phone, type;
    public int userId;
    public OzDate lastLog;

    private Connection con;
    private Db db = new Db();

    public User() {

    }

    public void newUser() throws SQLException {
        con = db.getConnect();
        insertUser();
        con.close();
    }

    public void getUser(int uId) throws SQLException {
        con = db.getConnect();
        select(uId);
        con.close();
    }

    public void getUserByEmail(String email) throws SQLException {
        con = db.getConnect();
        selectByEmail(email);
        con.close();
    }

    public boolean hasAccount(String email) throws SQLException {
        con = db.getConnect();
        boolean result = selectHasAccount(email);
        con.close();
        return result;
    }

    public int getUserId(String user) throws SQLException {
        con = db.getConnect();
        int result = 0;
        result = selectByName(user);
        con.close();
        return result;
    }

    public void newPassword(String pass) throws SQLException {
        con = db.getConnect();
        updatePassword(pass);
        con.close();
    }
    //DB Methods

    private void insertUser() throws SQLException {
        String stmt = "INSERT INTO user (userId, userName, passHash, firstName, surName, email, phone, type) VALUES (?,?,?,?,?,?,?,?)";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, 0);
        prepStmt.setString(2, userName);
        prepStmt.setString(3, passHash);
        prepStmt.setString(4, firstName);
        prepStmt.setString(5, surName);
        prepStmt.setString(6, email);
        prepStmt.setString(7, phone);
        prepStmt.setString(8, type);
        prepStmt.executeUpdate();
        prepStmt.close();
    }

    private void select(int uId) throws SQLException {
        String stmt = "SELECT * FROM user WHERE userId=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, uId);
        ResultSet rs = prepStmt.executeQuery();
        while (rs.next()) {
            getResultData(rs);
        }
        rs.close();
        prepStmt.close();
    }

    private void selectByEmail(String email) throws SQLException {
        String stmt = "SELECT * FROM user WHERE email=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setString(1, email);
        ResultSet rs = prepStmt.executeQuery();
        while (rs.next()) {
            getResultData(rs);
        }
        rs.close();
        prepStmt.close();
    }

    private boolean selectHasAccount(String email) throws SQLException {
        String stmt = "SELECT * FROM user WHERE email=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setString(1, email);
        ResultSet rs = prepStmt.executeQuery();
        if (rs.next()) {
            prepStmt.close();
            rs.close();
            return true;
        }
        prepStmt.close();
        rs.close();
        return false;
    }

    private int selectByName(String user) throws SQLException {
        String stmt = "SELECT * FROM user WHERE userName=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setString(1, user);
        int result = 0;
        ResultSet rs = prepStmt.executeQuery();
        while (rs.next()) {
            getResultData(rs);
            result = userId;
        }
        rs.close();
        prepStmt.close();
        return result;
    }

    private void updatePassword(String pass) throws SQLException {
        String stmt = "UPDATE user SET passHash=? WHERE userId=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setString(1, pass);
        prepStmt.setInt(2, userId);
        prepStmt.executeUpdate();
        prepStmt.close();
    }

    private void getResultData(ResultSet rs) throws SQLException {
        userId = rs.getInt("userId");
        userName = rs.getString("userName");
        passHash = rs.getString("passHash");
        firstName = rs.getString("firstName");
        surName = rs.getString("surName");
        email = rs.getString("email");
        phone = rs.getString("phone");
        type = rs.getString("type");
    }
}
