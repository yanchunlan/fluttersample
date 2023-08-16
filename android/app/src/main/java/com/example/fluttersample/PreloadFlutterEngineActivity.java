package com.example.fluttersample;


import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Arrays;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.RenderMode;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.FlutterShellArgs;

/**
 * author:  ycl
 * date:  2023/08/10 19:00
 * desc:  FlutterEngine预创建
 */
public class PreloadFlutterEngineActivity extends FlutterActivity {
    private static final String TAG = "SecondActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        if (FlutterEngineCache.getInstance().get(FlutterEngineUtil.engineId) != null) {
            getIntent()
                    .putExtra("cached_engine_id", FlutterEngineUtil.engineId) // 从缓存获取
                    .putExtra("enable_state_restoration", true) // 允许缓存数据
                    .putExtra("destroy_engine_with_activity", true); // 允许销毁
        }
        super.onCreate(savedInstanceState);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        FlutterEngineUtil.configureFlutterEngine(flutterEngine);
    }

    @NonNull
    @Override
    public RenderMode getRenderMode() {
        RenderMode mode = super.getRenderMode();
        Log.d(TAG, "getRenderMode: " + mode.name());
        return mode;
    }

    @Nullable
    @Override
    public String getCachedEngineId() {
        String cachedEngineId = super.getCachedEngineId();
        Log.d(TAG, "getCachedEngineId: " + cachedEngineId);
        return cachedEngineId;
    }

    @NonNull
    @Override
    public FlutterShellArgs getFlutterShellArgs() {
        FlutterShellArgs args = super.getFlutterShellArgs();
        Log.d(TAG, "getFlutterShellArgs: " + Arrays.toString(args.toArray()));
        return args;
    }

    @Override
    public boolean shouldRestoreAndSaveState() {
        boolean state = super.shouldRestoreAndSaveState();
        Log.d(TAG, "shouldRestoreAndSaveState: " + state);
        return state;
    }

    @Override
    public boolean shouldDestroyEngineWithHost() {
        boolean state = super.shouldDestroyEngineWithHost();
        Log.d(TAG, "shouldDestroyEngineWithHost: " + state);
        return state;
    }

    @NonNull
    @Override
    public String getAppBundlePath() {
        String path = super.getAppBundlePath();
        Log.d(TAG, "getAppBundlePath: " + path);
        return path;
    }

    @Nullable
    @Override
    public String getDartEntrypointLibraryUri() {
        String uri = super.getDartEntrypointLibraryUri();
        Log.d(TAG, "getAppBundlePath: " + uri);
        return uri;
    }

    @Nullable
    @Override
    public String getDartEntrypointFunctionName() {
        String name = super.getDartEntrypointFunctionName();
        Log.d(TAG, "getDartEntrypointFunctionName: " + name);
        return name;
    }

    @Nullable
    @Override
    public List<String> getDartEntrypointArgs() {
        List<String> args = super.getDartEntrypointArgs();
        Log.d(TAG, "getDartEntrypointArgs: " + args.toString());
        return args;
    }
}