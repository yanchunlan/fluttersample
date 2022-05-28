package com.example.android_project_a;

import android.content.Context;
import android.os.Bundle;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
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
        FlutterEngine flutterEngine = new FlutterEngine(this);
        flutterEngine.getNavigationChannel().setInitialRoute("route1");
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", flutterEngine);
        // 创建容器
        FlutterView flutterView = new FlutterView(this);
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
                300,
                300);
        FrameLayout layout = findViewById(R.id.id_main);
        layout.setBackgroundColor(ContextCompat.getColor(this, android.R.color.holo_green_light));
        layout.addView(flutterView,params);

        // attachToFlutterEngine 之后开始渲染
        flutterView.attachToFlutterEngine(flutterEngine);

    }
}