import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 360,
            minHeight: 100,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {});
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 360,
              minHeight: 100,
            ),
          ),
        ),
        // Text('hello'),
        // Text('world'),
      ],
    );
  }
}
