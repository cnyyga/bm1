package com.bm;

/**
 * Author:  mww .
 * ********************************
 * Date:  2018/4/25
 * ********************************
 * UpdateBy :
 * <p>
 * <p>
 * ********************************
 * Remarks:
 */
public enum TopupStatus {
    NO(0,"否"),
    YES (1,"是");

    Integer id;
    String label;

    TopupStatus(Integer id, String label) {
        this.id = id;
        this.label = label;
    }

    public Integer getId() {
        return id;
    }

    public String getLabel() {
        return label;
    }
}
