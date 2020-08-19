/*
 * SnowCon.java
 *
 * Created on 10 Dec 2012
 */
package utils;

/**
 *
 * @author Server
 * @version
 */
//<editor-fold defaultstate="collapsed" desc="Imports">
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
//</editor-fold>

public class Db {

    Connection con;

    /**
     * Creates new LocCon
     */
    public Db() {
    }

    public Connection getConnect() throws SQLException {
        try {
            Context initialContext = new InitialContext();

            /**
             * Get Context object for all environment naming (JNDI), such as
             * Resources configured for this web application.
             */
            Context environmentContext = (Context) initialContext
                    .lookup("java:comp/env");
            /**
             * Name of the Resource we want to access.
             */
            //e2(aG+bvcSO*
            //tetradeca
            String dataResourceName = "jdbc/SkinDeep";
            /**
             * Get the data source for the MySQL to request a connection.
             */
            DataSource dataSource = (DataSource) environmentContext
                    .lookup(dataResourceName);

            con = dataSource.getConnection();

        } catch (NamingException ex) {
            throw new SQLException(ex.getMessage());
        }
        return con;
    }

}
