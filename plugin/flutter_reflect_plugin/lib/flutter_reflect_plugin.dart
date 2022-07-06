import 'dart:async';

import 'package:flutter/services.dart';

class FlutterReflectPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_reflect_plugin');

  static Future<dynamic> methodTemplate(
      String methodName, List<dynamic> params) async {
    print("methodTemplate methodName $methodName params $params");
    dynamic result = await _channel.invokeMethod("invoke", {
      "method": methodName,
      "params": params,
    });
    return result;
  }

  @override
  Future<dynamic> noSuchMethod(Invocation invocation) {
    String methodName = getSymbolName(invocation.memberName);
    dynamic args = invocation.positionalArguments;
    print('noSuchMethod methodName:$methodName args:$args');
    return methodTemplate(methodName, args);
  }

  static String getSymbolName(Symbol symbol) {
    String string = symbol.toString();
    return string.substring(8, string.length - 2);
  }
}
