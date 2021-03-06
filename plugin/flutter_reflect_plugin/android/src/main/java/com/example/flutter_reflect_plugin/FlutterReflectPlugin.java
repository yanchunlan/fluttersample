package com.example.flutter_reflect_plugin;

import androidx.annotation.NonNull;
import android.content.Intent;
import android.net.Uri;
import android.content.Context;

import java.lang.reflect.Array;
import java.lang.reflect.Method;
import java.util.ArrayList;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterReflectPlugin
 */
public class FlutterReflectPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context context;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_reflect_plugin");
        channel.setMethodCallHandler(this);

        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("invoke")) {

            String method = call.argument("method");
            ArrayList params = call.argument("params");

            Object ret = null;

            try {
                Class<?> c = FlutterReflectPlugin.class;

                Method m = null;
                if (params.size() > 0) {
                    m = c.getMethod(method, ArrayList.class);
                    ret = m.invoke(this, params);

                } else {
                    m = c.getMethod(method);
                    ret = m.invoke(this);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            result.success(ret);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    public String platformVersion() {
        return "Android " + android.os.Build.VERSION.RELEASE;
    }

    public void openAppStore(ArrayList param) {
        String appID = (String)param.get(0);
        Uri uri = Uri.parse("market://details?id=" + appID);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

        context.startActivity(intent);
    }

}
