import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  String _platformVersion = 'Unknown';


  @override
  void initState() {
    super.initState();
    initCrash();
    initPlatformState();
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


    return Scaffold(
      appBar: AppBar(
        title: Text('CrashPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('platformVersion $_platformVersion'),
            MaterialButton(
              child: Text('Dart exception'),
              elevation: 1.0,
              onPressed: () {
                throw StateError('This is a Dart exception.');
              },
            ),
            new MaterialButton(
              child: Text('async Dart exception'),
              elevation: 1.0,
              onPressed: () {
                try {
                  Future.delayed(Duration(seconds: 1)).then((e) =>
                      throw StateError('This is a Dart exception in Future.'));
                } catch (e) {
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
