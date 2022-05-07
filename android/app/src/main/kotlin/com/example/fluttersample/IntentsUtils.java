package com.example.fluttersample;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

/**
 * author:  ycl
 * date:  2022/05/07 10:45
 * desc:
 */
public class IntentsUtils {
    private static final String TAG = "IntentsUtils";

    public static void showSecondActivity(Activity activity) {
        Log.d(TAG, "showSecondActivity: ");
        Intent intent = new Intent(activity, SecondActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT|Intent.FLAG_ACTIVITY_SINGLE_TOP);
//        intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
        activity.startActivityIfNeeded(intent, 0);
        activity.overridePendingTransition(0,0);
    }

    public static void showMainActivity(Activity activity) {
        Log.d(TAG, "showMainActivity");
//        try {
//        Intent intent = new Intent(activity, Class.forName("com.example.myapplication.MainActivity"));

        Intent intent = new Intent();
        intent.setClassName(activity,"com.example.fluttersample.MainActivity");
        intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT|Intent.FLAG_ACTIVITY_SINGLE_TOP);
//        intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
        activity.overridePendingTransition(0,0);
        activity.startActivity(intent);
//        overridePendingTransition(R.anim.bottom_silent, R.anim.bottom_out);
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//        Intent intent = new Intent();
//        intent.setClassName(activity.getApplicationContext(),"com.example.myapplication.MainActivity");
//        intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT | Intent.FLAG_ACTIVITY_SINGLE_TOP);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            String packageName = activity.getPackageName();
//            PowerManager pm = (PowerManager) activity.getSystemService(POWER_SERVICE);
//            if (!pm.isIgnoringBatteryOptimizations(packageName)) {
//                intent.setAction(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
//                intent.setData(Uri.parse("package:" + packageName));
//            }else {
//                intent.setAction(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS);
//            }
//        }
//        activity.startActivity(intent);
////        overridePendingTransition(R.anim.bottom_silent, R.anim.bottom_out);
//        activity.overridePendingTransition(0,0);
    }
}
