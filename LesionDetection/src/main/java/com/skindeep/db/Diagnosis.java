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
    public float akiec;
    public float bcc;
    public float bkl;
    public float df;
    public float mel;
    public float nv;
    public float vasc;
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
        String stmt = "INSERT INTO diagnosis (dxId, userId, lesionId, akiec, bcc, bkl, df, mel, nv, vasc, verified) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, dxId);
        prepStmt.setInt(2, userId);
        prepStmt.setInt(3, lesionId);
        prepStmt.setFloat(4, akiec);
        prepStmt.setFloat(5, bcc);
        prepStmt.setFloat(6, bkl);
        prepStmt.setFloat(7, df);
        prepStmt.setFloat(8, mel);
        prepStmt.setFloat(9, nv);
        prepStmt.setFloat(10, vasc);
        prepStmt.setBoolean(11, verified);
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
        akiec = rs.getFloat("akiec");
        bcc = rs.getFloat("bcc");
        bkl = rs.getFloat("bkl");
        df = rs.getFloat("df");
        mel = rs.getFloat("mel");
        nv = rs.getFloat("nv");
        vasc = rs.getFloat("vasc");
        verified = rs.getBoolean("verified");
    }

}
