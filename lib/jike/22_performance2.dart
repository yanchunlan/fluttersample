import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'dart:async';

import 'dart:ui';
import '22_fps_calculate.dart';
import '22_pv_exception.dart';

void main() async{
  FlutterError.onError = (FlutterErrorDetails details) async {
    //将异常转发至Zone
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned<Future<Null>>(() async {
    runApp(const MyApp());


    orginalCallback = window.onReportTimings;
    window.onReportTimings = onReportTimings;

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
        MyObserver(),
      ],

      home: PerformancePage(),
    );
  }
}


class PerformancePage2 extends StatefulWidget {
  int startTime;
  int endTime;

  const PerformancePage2({Key? key}) :
        startTime = DateTime.now().millisecondsSinceEpoch,
        super(key: key);

  @override
  State<PerformancePage2> createState() => _PerformancePage2State();
}

class _PerformancePage2State extends State<PerformancePage2> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.endTime = DateTime.now().millisecondsSinceEpoch;
      int timeSpend = widget.endTime - widget.startTime;
      print("PerformancePage2 render time:${timeSpend} ms");
    })
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:',),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
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