
import 'dart:async';

import 'package:flutter/services.dart';

class Crash {
  static const MethodChannel _channel = MethodChannel('crash_plugin');

  static void setUp(String appID) {
    _channel.invokeMethod("setUp",{'app_id':appID});
  }
  static void postException(String error, String? stack) {
    _channel.invokeMethod("postException",{'crash_message':error,'crash_detail':stack??""});
  }

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
