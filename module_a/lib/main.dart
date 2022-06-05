import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'default_page.dart';

void main() => runApp(_widgetForRoute()); //独立运行传入默认路由

Widget _widgetForRoute() {
  String route = window.defaultRouteName;
  print("_widgetForRoute route $route");
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
    case '/':
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.red,
          body: Center(
            child: Text('module a Unknown route: $route',
                textDirection: TextDirection.ltr),
          ),
        ),
      );
    default:
      return MaterialApp(
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            })),
        home: DefaultPage(),
      );
  }
}
