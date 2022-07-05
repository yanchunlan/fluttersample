import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:crash/crash.dart';
import 'dart:io';

void main() {

  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current
        .handleUncaughtError(details.exception, details.stack ?? StackTrace.empty);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    {
      return Scaffold(
          body: Center(
            child: Text("Custom Error Widget"),
          ));
    }
  };

  runZoned(() {
    runApp(const MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('_reportError $error \n stackTrace $stackTrace');
  Crash.postException(error, stackTrace);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initCrash();
  }


  void initCrash() {
    if(Platform.isAndroid){
      Crash.setUp('219c1d46ab');
    }else if(Platform.isIOS){
      Crash.setUp('219c1d46ab');
    }
  }


  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await Crash.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),

            RaisedButton(
              child: Text('Dart exception'),
              elevation: 1.0,
              onPressed: () {
                throw StateError('This is a Dart exception.');
              },
            ),

            RaisedButton(
              child: Text('async Dart exception'),
              elevation: 1.0,
              onPressed: () async {
                foo() async {
                  throw StateError('This is an async Dart exception.');
                }
                bar() async {
                  await foo();
                }
                await bar();
              },
            ),


          ],
        ),
      ),
    );
  }

}
