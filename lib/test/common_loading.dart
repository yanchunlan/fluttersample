import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CommonLoading {
  static Future<void> show({required String status, required Widget indicator, required EasyLoadingMaskType maskType, required bool dismissOnTap}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..backgroundColor = Colors.amber
      ..indicatorColor = Colors.amber
      ..textColor = Colors.amber;

    return EasyLoading.show(status: status, indicator: indicator, maskType: maskType, dismissOnTap: dismissOnTap);
  }

  static Future<void> dismiss({
    bool animation = true,
  }) {
    // cancel timer
    return EasyLoading.dismiss(animation: animation);
  }
}
