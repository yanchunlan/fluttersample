package com.example.fluttersample

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        registerMethodChannel()
        registerMethodChannel1()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    private fun registerMethodChannel1() {
        val registrar = ShimPluginRegistry(flutterEngine!!)
            .registrarFor("example.native_method/NativeViews")
        val playerViewFactory = SampleViewFactory(registrar.messenger())
        registrar.platformViewRegistry().registerViewFactory("SampleView", playerViewFactory)
    }

    // flutter 调用原生代码
    private fun registerMethodChannel() {
        MethodChannel(
            flutterEngine?.dartExecutor,
            "example.native_method/navigation"
        ).setMethodCallHandler { call, result ->
            if (call.method.equals("openAppStore")) {
                try {
                    val uri = Uri.parse("market://details?id=com.tencent.mm")
                    val intent = Intent(Intent.ACTION_VIEW, uri)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    startActivity(intent)
                    result.success(0)
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "没有安装应用市场", null)
                }
            } else if (TimeRecordUtils.getInstance().isStartTime(call.method)) {
                result.success(TimeRecordUtils.getInstance().startTime)
            } else if (TimeRecordUtils.getInstance().isStartUpPref(call.method)) {
                result.success(false)
            } else {
                result.notImplemented()
            }
        }
    }

    class SampleViewFactory(val messenger: BinaryMessenger) :
        PlatformViewFactory(StandardMessageCodec.INSTANCE) {
        override fun create(
            context: Context?, viewId: Int,
            args: Any?
        ): PlatformView {
            return SimpleViewControl(context, viewId, messenger);
        }
    }

    class SimpleViewControl(
        context: Context?, viewId: Int,
        messenger: BinaryMessenger?
    ) : PlatformView, MethodChannel.MethodCallHandler {
        var mView: View = View(context)
        var methodChannel: MethodChannel

        init {
            mView.setBackgroundColor(Color.rgb(255, 0, 0));

            methodChannel = MethodChannel(messenger, "example.native_method/native_views_$viewId")
            methodChannel.setMethodCallHandler(this)
        }

        override fun getView(): View {
            return mView
        }

        override fun dispose() {

        }

        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
            if (call.method.equals("changeBackgroundColor")) {
                view.setBackgroundColor(Color.rgb(0, 0, 255));


                result.success(0);
            } else {
                result.notImplemented();
            }
        }
    }

}
