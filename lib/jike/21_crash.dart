import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter_crash_plugin/flutter_crash_plugin.dart';
import 'dart:io';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  }

  ErrorWidget.builder = (FlutterErrorDetails details) {
    {
      return Scaffold(
          body: Center(
            child: Text("Custom Error Widget"),
          )
      );
    }
  }

  runZoned<Future<Null>>(() {
    runApp(const MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}


Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  print('Reporting to Bugly...');
  FlutterCrashPlugin.postException(error, stackTrace);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      FlutterCrashPlugin.setUp('43eed8b173');
    } else if (Platform.isIOS) {
      FlutterCrashPlugin.setUp('088aebe0d5');
    }

    return MaterialApp(
      title: 'CrashPage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CrashPage(),
    );
  }
}

class CrashPage extends StatefulWidget {
  const CrashPage({Key? key}) : super(key: key);

  @override
  State<CrashPage> createState() => _CrashPageState();
}

class _CrashPageState extends State<CrashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CrashPage'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Dart exception'),
              elevation: 1.0,
              onPressed: () {
                throw StateError('This is a Dart exception.');
              },
            ),
            new RaisedButton(
              child: Text('async Dart exception'),
              elevation: 1.0,
              onPressed: () {
                try {
                  //Future.delayed(Duration(seconds: 1)).then((e) => Future.error("This is an async Dart exception."));
                  Future.delayed(Duration(seconds: 1)).then((e) =>
                  throw StateError('This is a Dart exception in Future.'));
                }
                catch (e) {
                  print("This line will never be executed. ");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



