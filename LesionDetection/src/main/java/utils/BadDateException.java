/*
 * BadDateException.java
 *
 * Created on 25 November 2008, 13:26
 */
package utils;

/**
 *
 * @author Server
 * @version
 */
public class BadDateException extends java.lang.Exception {

    /**
     * Creates new <code>BadDateException</code> without detail message.
     */
    public BadDateException() {
    }

    /**
     * Constructs an <code>BadDateException</code> with the specified detail
     * message.
     *
     * @param msg the detail message.
     */
    public BadDateException(String msg) {
        super(msg);
    }
}
