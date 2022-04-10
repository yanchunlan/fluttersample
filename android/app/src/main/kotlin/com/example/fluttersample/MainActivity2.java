package com.example.fluttersample;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;
import io.flutter.embedding.android.FlutterActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity2 extends FlutterActivity{

    private long mainAct_onCreate_time=0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(
                getFlutterEngine().getDartExecutor(),
                "example.native_method/navigation"
        ).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals("openAppStore")) {
                    try {
                        Uri uri = Uri.parse("market://details?id=com.tencent.mm");
                        Intent intent =new  Intent(Intent.ACTION_VIEW, uri);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        result.success(0);
                    } catch (Exception e) {
                        result.error("UNAVAILABLE", "没有安装应用市场", null);
                    }
                } else if (call.method.equals("getStartTime")) {
                    // MainUnityActivity.open(MainActivity.this);
                    Map<String, Long> map = new HashMap<>();
                    map.put("app_init_time",MainApplication.instance.app_init_time);
                    map.put("app_attachBaseContext_time",MainApplication.instance.app_attachBaseContext_time);
                    map.put("app_onCreate_time",MainApplication.instance.app_onCreate_time);
                    map.put("mainAct_onCreate_time",mainAct_onCreate_time);
                    result.success(map);
                } else {
                    result.notImplemented();
                }
            }
        });
    }
}
