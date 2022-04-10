package com.example.fluttersample;
import android.app.Application;

import java.util.HashMap;
import java.util.Map;


public class MainApplication extends Application{

    public long app_init_time=0;
    public long app_attachBaseContext_time=0;
    public long app_onCreate_time=0;

    static MainApplication instance ;

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        Map<String, Long> map = new HashMap<>();
    }
}
