import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_crash_plugin/flutter_crash_plugin.dart';
import 'dart:io';


int exceptionCount = 0;
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  exceptionCount++; //累加异常次数

  print('_reportError $error stackTrace $stackTrace');
  FlutterCrashPlugin.postException(error, stackTrace);
}


int totalPV = 0;
class BaseObserver extends NavigatorObserver{

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    totalPV++;//累加PV
  }
}

// 页面异常
double pageException(){
  if(totalPV == 0) return 0;
  return exceptionCount/totalPV;
}
