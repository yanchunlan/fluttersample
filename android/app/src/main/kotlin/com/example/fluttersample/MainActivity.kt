package com.example.fluttersample

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
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
    private val TAG = "MainActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "onCreate: ")

        window.decorView.background = null
        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LOW_PROFILE
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.statusBarColor = 0x00000000
        }

        registerMethodChannel()
        registerMethodChannel1()
    }

    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart: ")
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume: ")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy: ")
    }

    @SuppressLint("MissingPermission")
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.i(TAG, " onNewIntent")
        if (intent.flags or Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT > 0) {
            if (Build.VERSION.SDK_INT >= 19 && !isTaskRoot) {
                val manager = getSystemService(ACTIVITY_SERVICE) as ActivityManager
                manager.moveTaskToFront(taskId, ActivityManager.MOVE_TASK_NO_USER_ACTION)
                Log.d(TAG, "onNewIntent moveTaskToFront")
                if (!Utils.isRunningForeground(this@MainActivity)) {
                    Utils.moveAppToFront(this@MainActivity)
                }
            }
        }
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
            } else if (TimeRecordUtils.getInstance().isJumpSecond(call.method)) {
                IntentsUtils.showSecondActivity(this)
                result.success(0)
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
