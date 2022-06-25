package com.example.android_project_a;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.os.MessageQueue;
import android.util.Log;

import java.util.concurrent.LinkedBlockingQueue;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.loader.FlutterLoader;

public class FlutterCacheManager {
    private static final String TAG = "FlutterCacheManager";
    private LinkedBlockingQueue<FlutterEngine> queue = new LinkedBlockingQueue<>();
    private Context context;

    public FlutterCacheManager(Context context) {
        this.context = context;
    }

    public static FlutterCacheManager newInstance(Context context) {
        return new FlutterCacheManager(context);
    }

    public FlutterEngine getCachedFlutterEngine() {
        if (queue.isEmpty()) return null;
        return queue.poll();
    }

    public FlutterEngine createFlutterEngine() {
        FlutterEngine flutterEngine = createFlutterEngine(context);
        if (!queue.contains(flutterEngine)) queue.offer(flutterEngine);
        return flutterEngine;
    }

    public void preLoad() {
        Looper.getMainLooper().myQueue().addIdleHandler(new MessageQueue.IdleHandler() {
            @Override
            public boolean queueIdle() {
                createFlutterEngine();
                return false;
            }
        });
    }

    private FlutterEngine createFlutterEngine(Context context) {
        FlutterEngine flutterEngine = new FlutterEngine(context);
        flutterEngine.getNavigationChannel().setInitialRoute("route1");
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache
                .getInstance()
                .put("default_engine", flutterEngine);
        return flutterEngine;
    }

    public void preLoadDartVV() {
        FlutterLoader.getInstance().startInitialization(context);
        Handler handler = new Handler(Looper.getMainLooper());
        FlutterLoader.getInstance().ensureInitializationCompleteAsync(
                context,
                new String[]{},
                handler,
                () -> Log.d(TAG, "run: preLoadDartVV done"));

    }
}
