package com.example.fluttersample;


import android.content.Context;

import java.util.ArrayList;

import io.flutter.Log;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.FlutterShellArgs;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * author:  ycl
 * date:  2023/08/10 18:42
 * desc:  FlutterEngine预创建
 */
public class FlutterEngineUtil {
    private static final String TAG = "FlutterEngineUtil";
    static final String engineId = "default_engine";

    public static void preloadFlutterEngine(Context context){
        Log.setLogLevel(Log.VERBOSE);

        ArrayList<String> args = new ArrayList<>();
        if(BuildConfig.DEBUG){
//        args.add(FlutterShellArgs.ARG_START_PAUSED); // 启动创建，不需要--start-paused
            args.add(FlutterShellArgs.ARG_ENABLE_DART_PROFILING);
        }
        FlutterEngine flutterEngine = new FlutterEngine(context,
                new FlutterShellArgs(args).toArray(),
                false, // 首次创建不自动注册插件，否则context.getActivity抱错
                true // 运行恢复数据
        );
        flutterEngine.getNavigationChannel().setInitialRoute("/");
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache.getInstance().put(engineId, flutterEngine);
    }

    public static void configureFlutterEngine(FlutterEngine flutterEngine) {
        if (FlutterEngineCache.getInstance().get(FlutterEngineUtil.engineId) == null) return;
        GeneratedPluginRegistrant.registerWith(flutterEngine);// 必须在activity中注册，因为部分插件需要获取activity
    }
}
