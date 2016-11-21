package com.bm.utils;

import org.apache.commons.lang.StringUtils;

/**
 * .
 * Created by mawenwu on 2016/11/15.
 */
public class MyNetUtils {

    private final static String[] uas = new String[]{"Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"};

    public static boolean checkMobile(String userAgent){
        if(StringUtils.isEmpty(userAgent)){
            return false;
        }
        return StringUtils.indexOfAny(userAgent, uas)>0;
    }
}
