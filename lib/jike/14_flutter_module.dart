import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
// module_a

void main() {
  runApp(const Module_a_test());
}

class Module_a_test extends StatelessWidget {
  const Module_a_test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widgetForRoute();
  }
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
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        })),
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

const methodChannel = MethodChannel('example.native_method/navigation');

class PageA extends StatelessWidget {
  PageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(title: Text("Flutter Page A")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Page A',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              MaterialButton(
                  child: Text("Go Native Page"),
                  onPressed: () => methodChannel.invokeMethod('openNativePage'))
            ],
          ),
        ));
  }
}

class DefaultPage extends StatelessWidget {
  DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
            title: Text("Flutter Default Page"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () =>
                    methodChannel.invokeMethod('closeFlutterPage'))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Default Page',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              MaterialButton(
                child: Text("Go Page A"),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PageA())),
              )
            ],
          ),
        ));
  }
}
