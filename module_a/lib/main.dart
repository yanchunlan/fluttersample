import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(Module_a_test()); //独立运行传入默认路由


class Module_a_test extends StatelessWidget {
  const Module_a_test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widgetForRoute();
  }
}

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
