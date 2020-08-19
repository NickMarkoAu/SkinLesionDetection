/*
 * Login.java
 *
 * Created on 5 December 2008, 11:06
 */
package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Server
 * @version
 */
public class Log {

    private Connection con;
    private Db snowDb = new Db();

    /**
     * Creates new Login
     */
    public Log() {
    }

    public boolean agentLog(String uName, String pass) throws SQLException {
        boolean result = false;
        con = snowDb.getConnect();
        result = checkLog(uName, pass);
        con.close();
        con = null;
        return result;
    }

    public void storeAuth(String token, int uId) throws SQLException {
        con = snowDb.getConnect();
        insertAuth(token, uId);
        con.close();
    }

    public boolean authenticate(String token, int uId) throws SQLException {
        con = snowDb.getConnect();
        boolean result = false;
        result = checkAuth(token, uId);
        con.close();
        return result;
    }

  

    private boolean checkLog(String uName, String pass) throws SQLException {
        boolean result = false;
        String stmt = "SELECT passHash FROM user WHERE username=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setString(1, uName);
        ResultSet rs = prepStmt.executeQuery();
        String token = "";
        while (rs.next()) {
            token = rs.getString("passHash");
        }
        PasswordAuthentication auth = new PasswordAuthentication();
        result = auth.authenticate(pass.toCharArray(), token);
        prepStmt.close();
        rs.close();
        return result;
    }

    private void insertAuth(String token, int uId) throws SQLException {
        String stmt = "UPDATE user SET authToken=? WHERE userId=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setString(1, token);
        prepStmt.setInt(2, uId);
        prepStmt.executeUpdate();
        prepStmt.close();
    }

    private boolean checkAuth(String token, int uId) throws SQLException {
        String stmt = "SELECT authToken FROM user WHERE userId=?";
        PreparedStatement prepStmt = con.prepareStatement(stmt);
        prepStmt.setInt(1, uId);
        ResultSet rs = prepStmt.executeQuery();
        boolean result = false;
        String authToken = "";
        while (rs.next()) {
            authToken = rs.getString("authToken");
        }
        if (Var.matches(token, authToken)) {
            result = true;
        }
        prepStmt.close();
        rs.close();
        return result;
    }

}
