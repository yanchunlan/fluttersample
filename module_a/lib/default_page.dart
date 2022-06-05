import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

// module_a
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
              RaisedButton(
                  child: Text("Go Native Page"),
                  onPressed: () => methodChannel.invokeMethod('openNativePage')),
              RaisedButton(
                  child: Text("finish Page A"),
                  onPressed: () => Navigator.pop(context)),
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
                onPressed: () => methodChannel.invokeMethod('closeFlutterPage'))),
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
              RaisedButton(
                child: Text("Go Page A"),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PageA())),
              ),
              RaisedButton(
                child: Text("finish flutter Act"),
                onPressed: () => methodChannel.invokeMethod('closeFlutterPage'),
              ),
            ],
          ),
        ));
  }
}
