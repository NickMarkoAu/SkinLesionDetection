/*
________             _________                      ___________           .__      
\_____  \ ________  /   _____/ ____   ______  _  __ \__    ___/___   ____ |  |__   
 /   |   \\___   /  \_____  \ /    \ /  _ \ \/ \/ /   |    |_/ __ \_/ ___\|  |  \  
/    |    \/    /   /        \   |  (  <_> )     /    |    |\  ___/\  \___|   Y  \ 
\_______  /_____ \ /_______  /___|  /\____/ \/\_/     |____| \___  >\___  >___|  / 
        \/      \/         \/     \/                             \/     \/     \/ 

Copyright (C) OzSnow PTY LTD - All Rights Reserved
Unauthorized copying of this file, via any medium is strictly prohibited
Proprietary and confidential

All software provided to any third party with a separate licence must be used for good and not evil!

Written by Nick Marko <tech@ozsnow.com>
 */
package com.skindeep.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.BadDateException;
import utils.Db;
import utils.OzDate;

/**
 *
 * @author nickm
 */
public class LesionEntry {

    public OzDate dateNoticed, dateLogged;
    public int userId;
    private int lesionId;
    public String description;
    public String image;
    public String bodyPart;
    public boolean diagnosed;

    private Connection con;
    private Db db = new Db();

    public LesionEntry() {
    }

    public int getId() {
        return lesionId;
    }

    public ArrayList getByUser(int userId) throws SQLException {
        ArrayList result = new ArrayList();
        con = db.getConnect();
        result = selectByUser(userId);
        con.close();
        con = null;
        return result;
    }

    public void store() throws SQLException {
        con = db.getConnect();
        insert();
        con.close();
        con = null;
    }

    public void find(int id) throws SQLException {
        con = db.getConnect();
        select(id);
        con.close();
        con = null;
    }

    public int getNextId() throws SQLException {
        con = db.getConnect();
        int result = selectNextId();
        con.close();
        con = null;
        return result;
    }

    private ArrayList selectByUser(int userId) throws SQLException {
        ArrayList result = new ArrayList();
        String stmt = "SELECT * FROM lesions WHERE userId=?";
        try ( PreparedStatement prepStmt = con.prepareStatement(stmt)) {
            prepStmt.setInt(1, userId);
            try ( ResultSet rs = prepStmt.executeQuery()) {
                while (rs.next()) {
                    LesionEntry entry = new LesionEntry();
                    entry.getResultData(rs);
                    result.add(entry);
                }
            }
        }
        return result;
    }

    private void select(int id) throws SQLException {
        String stmt = "SELECT * FROM lesions WHERE lesionId=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, id);
        ResultSet rs = prepStmt.executeQuery();
        while (rs.next()) {
            this.getResultData(rs);
        }
    }

    private void insert() throws SQLException {
        String stmt = "INSERT INTO lesions (lesionId, userId, description, image, dateLogged, bodyPart, diagnosed) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, 0);
        prepStmt.setInt(2, userId);
        prepStmt.setString(3, description);
        prepStmt.setString(4, image);
        prepStmt.setString(5, dateLogged.toDb());
        prepStmt.setString(6, bodyPart);
        prepStmt.setBoolean(7, diagnosed);
        prepStmt.executeUpdate();
        prepStmt.close();

    }

    private int selectNextId() throws SQLException {
        String stmt = "SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'skindeep' AND TABLE_NAME = 'lesions'";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        int result = 0;
        ResultSet rs = prepStmt.executeQuery();
        while (rs.next()) {
            result = rs.getInt("AUTO_INCREMENT");
        }
        prepStmt.close();
        rs.close();
        return result;
    }

    protected void getResultData(ResultSet rs) throws SQLException {
        this.userId = rs.getInt("userId");
        this.lesionId = rs.getInt("lesionId");
        this.description = rs.getString("descr");
        this.image = rs.getString("image");
        this.bodyPart = rs.getString("bodyPart");
        this.diagnosed = rs.getBoolean("diagnosed");
        try {
            this.dateLogged = new OzDate(rs.getString("dateLogged"));
            this.dateNoticed = new OzDate(rs.getString("dateNoticed"));
        } catch (BadDateException e) {

        }

    }
}
