package com.example.crash;

import androidx.annotation.NonNull;
import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.tencent.bugly.crashreport.CrashReport;

/** CrashPlugin */
public class CrashPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "crash_plugin");
    channel.setMethodCallHandler(this);

    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("setUp")) {
      String appID = call.argument("app_id");
      CrashReport.initCrashReport(context, appID, true);
      result.success(0);
    } else  if (call.method.equals("postException")) {
      String message = call.argument("crash_message");
      String detail = call.argument("crash_detail");
      CrashReport.postException(4,"Flutter Exception",message,detail,null);
      result.success(0);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
