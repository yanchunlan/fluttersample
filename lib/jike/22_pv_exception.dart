import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';


int exceptionCount = 0;
Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  exceptionCount++; //累加异常次数

  print('_reportError $error stackTrace $stackTrace');
  // Crash.postException(error, stackTrace);
}


int totalPV = 0;
class BaseObserver extends NavigatorObserver{

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('didPush route $route previousRoute $previousRoute');
    totalPV++;//累加PV
  }

  @override
  void didStopUserGesture() {
    print('didStopUserGesture');

  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didStartUserGesture route $route previousRoute $previousRoute');

  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('didReplace route $newRoute previousRoute $oldRoute');

  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didRemove route $route previousRoute $previousRoute');

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didPop route $route previousRoute $previousRoute');

  }

}

// 页面异常
double pageException(){
  if(totalPV == 0) return 0;
  return exceptionCount/totalPV;
}
