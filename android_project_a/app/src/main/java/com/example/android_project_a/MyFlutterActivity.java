package com.example.android_project_a;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MyFlutterActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_my_flutter);

        MethodChannel methodChannel = createMethodChannel(getFlutterEngine());
    }


    private MethodChannel createMethodChannel(FlutterEngine flutterEngine) {
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor(),
                "example.native_method/navigation");
        methodChannel.setMethodCallHandler((call, result) -> {
            if(call.method.equals("openNativePage")) {
                //新建Intent，打开原生页面
                Intent intent = new Intent(this, MyNativeActivity.class);
                startActivity(intent);
                result.success(0);
            } else if(call.method.equals("closeFlutterPage")) {
                finish();
                result.success(0);
            } else {
                result.notImplemented();
            }
        });
        return methodChannel;
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

}