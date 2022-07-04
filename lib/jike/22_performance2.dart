import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'dart:async';

import 'dart:ui';
import './22_fps_calculate.dart';
import './22_pv_exception.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    //将异常转发至Zone
    Zone.current.handleUncaughtError(
        details.exception, details.stack ?? StackTrace.empty);
  };

  runZoned<Future<Null>>(() async {
    runApp(const MyApp());

    // originalCallback = window.onReportTimings;
    // window.onReportTimings = onReportTimings;
    // 1.12.x 后fps需要改为下面方式获取
    startFpsListener();

  }, onError: (error, stackTrace) async {
    //拦截异常
    await reportError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PerformancePage2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        BaseObserver(),
      ],
      home: PerformancePage2(),
    );
  }
}

class PerformancePage2 extends StatefulWidget {
  // 统一定义为不是const类似数据
  int startTime;
  int endTime = 0;

  PerformancePage2({Key? key})
      : startTime = DateTime.now().millisecondsSinceEpoch,
        super(key: key);

  @override
  State<PerformancePage2> createState() => _PerformancePage2State();
}

class _PerformancePage2State extends State<PerformancePage2> {
  int _counter = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.endTime = DateTime.now().millisecondsSinceEpoch;
      // 页面加载时长
      int timeSpend = widget.endTime - widget.startTime;

      print("PerformancePage2 render time:${timeSpend} ms");
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PerformancePage2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'button click count:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text('pageException: ${pageException()}'),

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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
