package com.example.fluttersample;

import android.os.SystemClock;

import java.util.HashMap;
import java.util.Map;

/**
 * author:  ycl
 * date:  2022/05/07 10:36
 * desc:
 */
public class TimeRecordUtils {

    public long app_init_time=0;
    public long app_attachBaseContext_time=0;
    public long app_onCreate_time=0;

    public long mainAct_onCreate_time=0;


    private TimeRecordUtils() {
    }

    private static class Holder {
        private static final TimeRecordUtils instance = new TimeRecordUtils();
    }

    public static TimeRecordUtils getInstance() {
        return Holder.instance;
    }


    public long getCurrentTime() {
        return SystemClock.elapsedRealtime();
    }

    public boolean isStartTime(String method) {
        return method.equals("getStartTime");
    }

    public Map getStartTime() {
        Map<String, Long> map = new HashMap<>();
        map.put("app_init_time",app_init_time);
        map.put("app_attachBaseContext_time",app_attachBaseContext_time);
        map.put("app_onCreate_time",app_onCreate_time);
        map.put("mainAct_onCreate_time",mainAct_onCreate_time);
        return map;
    }

    public boolean isStartUpPref(String method){
        return method.equals("isStartUpPref");
    }

    public boolean isJumpSecond(String method){
        return method.equals("isJumpSecondAct");
    }

}
