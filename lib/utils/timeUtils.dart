import 'dart:async';

import 'package:flutter/services.dart';

class TimeUtils{

  static bool isDebug = true;

  static int getCurrentTime() {
    return isDebug ? new DateTime.now().millisecondsSinceEpoch : 0;
  }

  static int flutter_main_start_time=0;
  static int flutter_main_cost_time=0;
  static int flutter_app_init_start_time =0;
  static int flutter_app_init_cost_time=0;

  static Map<String,dynamic> timeRecord=new Map();

  static const MethodChannel mainMethodChannel = MethodChannel('example.native_method/navigation');

  static void setMethodCallHandler(){
    mainMethodChannel.setMethodCallHandler((MethodCall call){
      Completer<dynamic> completer = Completer();
      switch(call.method){
        case "getFlutterInfo":
          completer.complete(["flutter info test1","flutter info test2"]);
          break;
      }
      return completer.future;
    });
  }

  static Future<Map<dynamic, dynamic>?> getStartTime() async {
    return await mainMethodChannel.invokeMethod<Map<dynamic, dynamic>>('getStartTime');
  }
  static Future<dynamic> isStartUpPref() async {
    return await mainMethodChannel.invokeMethod<dynamic>('isStartUpPref');
  }



  static const EventChannel _eventChannel = EventChannel('example.native_method.eventChannel/test');

  static void eventChannelListener(){
    //监听原生端发送过来的事件
    _eventChannel.receiveBroadcastStream().listen((event){
      print("TimeUtils.eventChannelListener event $event");
    });
  }

}