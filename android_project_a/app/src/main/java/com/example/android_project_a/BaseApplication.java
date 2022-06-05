package com.example.android_project_a;

import android.app.Application;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class BaseApplication extends Application {

    FlutterEngine flutterEngine;

    @Override
    public void onCreate() {
        super.onCreate();
//        flutterEngine = createFlutterEngine();
    }

    @Override
    public void onTerminate() {
//        flutterEngine.destroy();
        super.onTerminate();
    }

    private FlutterEngine createFlutterEngine() {
        FlutterEngine flutterEngine = new FlutterEngine(this);
        flutterEngine.getNavigationChannel().setInitialRoute("route1");
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache
                .getInstance()
                .put("default_engine", flutterEngine);
        return flutterEngine;
    }
}
