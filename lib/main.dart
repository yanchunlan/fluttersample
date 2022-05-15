import 'package:flutter/material.dart';

import 'jike/jike_import.dart';
import 'widget/widget_import.dart';
import 'test/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _test(),
    );
  }
}


Widget _test() {
  return jikeWidget();
  // return TestPage();
}

Widget jikeWidget() {
  // return CommonPage();
  // return CustomUIPage();
  // return GesturePage();
  // return DataTransPage();
  // return RouteWidget();
  // return AnimationPage();
  return NetworkPage();
  // return NativeMethodLessWidget();
  // return ScreenPage();
}

Widget _test1() {
  return otherWidget();
}

Widget otherWidget() {
  // return ListViewPage();
  // return ScrollViewPage();
  return ContainerPage();
  // return ProgressPage();
}
