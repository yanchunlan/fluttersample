package com.example.android_project_a;

import android.app.Application;
import android.content.Context;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class BaseApplication extends Application {

    FlutterEngine flutterEngine;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
//        FlutterCacheManager.newInstance(this).preLoad();
    }

    @Override
    public void onCreate() {
        super.onCreate();
//        flutterEngine = FlutterCacheManager.newInstance(this).getCachedFlutterEngine();
    }

    @Override
    public void onTerminate() {
//        flutterEngine.destroy();
        super.onTerminate();
    }
}
