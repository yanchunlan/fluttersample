import 'package:flutter/material.dart';
import '../utils/Log.dart';
import '../utils/Log1.dart';
import '../utils/Log2.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LogPage"),
        ),
        body: Container(
          child: Column(
            children: [

              MaterialButton(
                onPressed: () {
                  Log.init(true);
                  Log1.init(true);
                  Log2.init(true);
                },
                child: Text("set Log.init(true)"),
              ),

              MaterialButton(
                onPressed: () {
                  Log.init(false);
                  Log1.init(false);
                  Log2.init(false);
                },
                child: Text("set Log.init(false)"),
              ),

              MaterialButton(
                onPressed: () {
                  Log.d('test');
                  Log1.d('test');
                  Log2.d('test');
                },
                child: Text("test"),
              ),

            ],
          ),
        ));
  }
}
