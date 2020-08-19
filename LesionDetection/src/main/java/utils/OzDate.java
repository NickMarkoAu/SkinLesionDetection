/*
 * OzDate.java
 *
 * Created on 25 November 2008, 13:25
 */
package utils;

/**
 *
 * @author Server
 * @version
 */
import java.util.*;
import java.text.*;

public class OzDate {

    Calendar theDate;

    private SimpleDateFormat db = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat oz = new SimpleDateFormat("dd/MM/yy");
    private SimpleDateFormat show = new SimpleDateFormat("dd-MMM-yy");
    private SimpleDateFormat dateMon = new SimpleDateFormat("dd-MMM");
    private SimpleDateFormat day = new SimpleDateFormat("EEE");
    private SimpleDateFormat fullShow = new SimpleDateFormat("EEE dd-MMM-yy");

    /**
     * Creates new OzDate
     */
    public OzDate() {
        theDate = null;
    }

    // constructor distinguishes db vs oz dates if 3rd char is '/'
    public OzDate(String sDate) throws BadDateException {
        if (Var.isFilled(sDate, 4)) {
            theDate = new GregorianCalendar();
            try {
                if (sDate.substring(2, 3).equals("/")) {
                    theDate.setTime(oz.parse(sDate));
                } else {
                    theDate.setTime(db.parse(sDate));
                }
            } catch (ParseException e) {
                theDate = null;
                throw new BadDateException("A DATE was entered in the wrong format.<BR>"
                        + "Go back and check the dates you have just entered.");
            }
        } else {
            theDate = null;
        }
    }

    public Calendar getDate() {
        return theDate;
    }

    public int getHour() {
        return theDate.get(Calendar.HOUR_OF_DAY);
    }

    public OzDate(Calendar cal) {
        theDate = new GregorianCalendar();
        theDate = cal;
    }

    public OzDate(int days) {
        theDate = new GregorianCalendar();
        if (days == 0) {
            return;
        }
        theDate.add(Calendar.DATE, days);
    }

    public boolean isNull() {
        if (theDate == null) {
            return true;
        } else {
            return false;
        }
    }

    public String toDb() {
        if (!(theDate == null)) {
            return db.format(theDate.getTime());
        } else {
            return null;
        }
    }

    public String toOz() {
        if (!(theDate == null)) {
            return oz.format(theDate.getTime());
        } else {
            return null;
        }
    }

    public String toShow() {
        if (!(theDate == null)) {
            return show.format(theDate.getTime());
        } else {
            return null;
        }
    }

    public String toFullShow() {
        if (!(theDate == null)) {
            return fullShow.format(theDate.getTime());
        } else {
            return null;
        }
    }

    public String toDateMon() {
        if (!(theDate == null)) {
            return dateMon.format(theDate.getTime());
        } else {
            return null;
        }
    }

    public String toDay() {
        if (!(theDate == null)) {
            return day.format(theDate.getTime());
        } else {
            return null;
        }
    }

    public String toString() {
        return toShow();
    }

    // returns a new Calendar with date of this.theDate + # days
    public Calendar addDays(int days) {
        Calendar newDate = new GregorianCalendar();
        newDate = (Calendar) theDate.clone();
        newDate.add(Calendar.DATE, days);
        return newDate;
    }

    // returns the number of days this.theDate is before nextDate
    public int daysBefore(OzDate nextDate) {
        if (nextDate.theDate == null) {
            return 0;
        }
        int result = 0;
        long diffMillis = nextDate.theDate.getTimeInMillis() - this.theDate.getTimeInMillis();
        result = (int) (Math.round(diffMillis / 86400000.0));
        return result;
    }

    // returns true if both dates are not null and toDB() formats are equal
    public boolean equals(OzDate oDate) {
        if (oDate.getDate() == null || this.theDate == null) {
            return false;
        }
        boolean result = false;
        if (this.toDb().equals(oDate.toDb())) {
            result = true;
        }
        return result;
    }

}
