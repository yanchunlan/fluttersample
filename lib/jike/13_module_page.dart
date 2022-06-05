import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
// module_a

void main() {
  runApp(_widgetForRoute());
}

Widget _widgetForRoute() {
  String route = window.defaultRouteName;
  switch (route) {
    case 'route1':
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.red,
          appBar: AppBar(
            title: Text('flutter页面'),
          ),
          body: Center(
            child: Text(
              'module a route $route',
            ),
          ),
        ),
      );
    default:
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.red,
          body: Center(
            child: Text('module a Unknown route: $route',
                textDirection: TextDirection.ltr),
          ),
        ),
      );
  }
}
