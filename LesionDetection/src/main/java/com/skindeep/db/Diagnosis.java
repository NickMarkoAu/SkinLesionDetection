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
import utils.Db;

/**
 *
 * @author nickm
 */
public class Diagnosis {

    Connection con;
    Db db = new Db();
    private int dxId;
    public int userId;
    public int lesionId;
    public double akiec;
    public double bcc;
    public double bkl;
    public double df;
    public double mel;
    public double nv;
    public double vasc;
    public String prediction, doctorDx;
    public boolean verified;

    public Diagnosis() {

    }

    public int getId() {
        return dxId;
    }

    public void store() throws SQLException {
        con = db.getConnect();
        insert();
        con.close();
        con = null;
    }

    public void findByLesion(int lId) throws SQLException {
        con = db.getConnect();
        selectByLesion(lId);
        con.close();
        con = null;
    }

    private void insert() throws SQLException {
        String stmt = "INSERT INTO diagnosis (dxId, userId, lesionId, akiec, bcc, bkl, df, mel, nv, vasc, prediction, verified, doctorDx) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, dxId);
        prepStmt.setInt(2, userId);
        prepStmt.setInt(3, lesionId);
        prepStmt.setDouble(4, akiec);
        prepStmt.setDouble(5, bcc);
        prepStmt.setDouble(6, bkl);
        prepStmt.setDouble(7, df);
        prepStmt.setDouble(8, mel);
        prepStmt.setDouble(9, nv);
        prepStmt.setDouble(10, vasc);
        prepStmt.setString(11, prediction);
        prepStmt.setBoolean(12, verified);
        prepStmt.setString(13, doctorDx);
        prepStmt.executeUpdate();
        prepStmt.close();
    }

    private void selectByLesion(int lId) throws SQLException {
        String stmt = "SELECT * FROM diagnosis WHERE lesionId=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, lId);
        ResultSet rs = prepStmt.executeQuery();
        while (rs.next()) {
            getResultData(rs);
        }
        rs.close();
        prepStmt.close();
    }

    protected void getResultData(ResultSet rs) throws SQLException {
        dxId = rs.getInt("dxId");
        userId = rs.getInt("userId");
        lesionId = rs.getInt("lesionId");
        akiec = rs.getDouble("akiec");
        bcc = rs.getDouble("bcc");
        bkl = rs.getDouble("bkl");
        df = rs.getDouble("df");
        mel = rs.getDouble("mel");
        nv = rs.getDouble("nv");
        vasc = rs.getDouble("vasc");
        verified = rs.getBoolean("verified");
        prediction = rs.getString("prediction");
        doctorDx = rs.getString("doctorDx");
    }

}
