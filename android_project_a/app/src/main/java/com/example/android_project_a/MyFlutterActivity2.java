package com.example.android_project_a;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;

public class MyFlutterActivity2 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_flutter2);
        initFlutterView();
    }


    public void startActivity(Context context){
        // 默认跳转
        context.startActivity(FlutterActivity.createDefaultIntent(context));

        // 跳转指定页面
//        Intent inteny = new FlutterActivity.IntentBuilder()
//                .initialRoute("someOtherRoute")
//                .build(context);
//        context.startActivity(inteny);
    }

    private void initFlutterFragment() {
        // 老的版本
//        Flutter.createFragment("route1");

        // 新的方式
        // 使用新Engine
        FlutterFragment flutterFragment1 = FlutterFragment.createDefault();
        // 使用老Engine
        FlutterFragment flutterFragment2 = FlutterFragment.withCachedEngine("my_engine_id").build();
    }

    // TODO 不知道为何，未生效？？？
    private void initFlutterView() {

        // 1. 老的方式，已废弃
//        View FlutterView = Flutter.createView(this, getLifecycle(), "defaultRoute"); //传入路由标识符
//        setContentView(FlutterView);//用FlutterView替代Activity的ContentView


        // 2. 新的方式，
        // 创建引擎
        FlutterEngine flutterEngine = createFlutterEngine();
        // 创建容器
        FlutterView flutterView = createFlutterView();
        // 创建通道
        MethodChannel methodChannel = createMethodChannel(flutterEngine);

        // attachToFlutterEngine 之后开始渲染
        flutterView.attachToFlutterEngine(flutterEngine);

    }

    private MethodChannel createMethodChannel(FlutterEngine flutterEngine) {
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor(),
                "example.native_method/navigation");
        methodChannel.setMethodCallHandler((call, result) -> {
            if(call.method.equals("openNativePage")) {
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

    private FlutterView createFlutterView() {
        FlutterView flutterView = new FlutterView(this);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                300,
                300);
        LinearLayout layout = findViewById(R.id.id_main);
        layout.setBackgroundColor(ContextCompat.getColor(this, android.R.color.holo_green_light));
        layout.addView(flutterView,params);
        return flutterView;
    }

    private FlutterEngine createFlutterEngine() {
        FlutterEngine flutterEngine = new FlutterEngine(this);
        flutterEngine.getNavigationChannel().setInitialRoute("route1");
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", flutterEngine);
        return flutterEngine;
    }

    public void onToNativeClick(View view) {
        Intent intent = new Intent(this, MyNativeActivity.class);
        startActivity(intent);
    }
}