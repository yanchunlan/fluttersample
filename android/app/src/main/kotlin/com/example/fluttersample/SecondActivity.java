package com.example.fluttersample;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ActivityManager;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;


public class SecondActivity extends Activity {
    private static final String TAG = "SecondActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        Log.d(TAG, "onCreate: ");
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.d(TAG, "onStart: ");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.d(TAG, "onResume: ");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "onDestroy: ");
    }

    @Override
    public void finish() {
        super.finish();
        Log.d(TAG, "finish: ");
    }


    @SuppressLint("MissingPermission")
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Log.d(TAG, "onNewIntent");

        if ((intent.getFlags() | Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT) > 0) {
            if (Build.VERSION.SDK_INT >= 19 && !isTaskRoot()) {
                ActivityManager manager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
                manager.moveTaskToFront(getTaskId(), ActivityManager.MOVE_TASK_NO_USER_ACTION);
                Log.d(TAG, "onNewIntent moveTaskToFront");
                if (!Utils.isRunningForeground(SecondActivity.this)) {
                    Utils.moveAppToFront(SecondActivity.this);
                }
            }
        }
//        Timer timer=new Timer();
//        timer.schedule(new TimerTask() {
//            @Override
//            public void run() {
//                if (!Utils.isRunningForeground(SecondActivity.this)) {
//                    Utils.moveAppToFront(SecondActivity.this);
//                }else {
//                    timer.cancel();
//                }
//
//            }
//        },0,1000);

        setIntent(intent);
    }


    public void clickToMainActivity(View view) {
        IntentsUtils.showMainActivity(this);
    }
}