
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNetworkPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_network_plugin');

  static Future<String> doRequest(url,params)  async {
    final String result = await _channel.invokeMethod('doRequest', {
      "url": url,
      "param": params,
    });
    return result;
  }
}
