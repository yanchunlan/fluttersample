import 'package:flutter/material.dart';

import 'jike/00_common.dart';
import 'jike/01_lifecycle.dart';
import 'jike/02_custom_ui.dart';
import 'jike/03_gesture.dart';
import 'jike/04_data_transfer.dart';
import 'jike/05_router.dart';
import 'jike/06_app_animation.dart';
import 'jike/07_dart_async.dart';
import 'jike/08_network.dart';
import 'jike/09_data_persistence.dart';
import 'jike/10_native_method.dart';
import 'weight/01_listviewpage.dart';
import 'weight/02_scrollview_page.dart';
import 'weight/03_container.dart';

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

  Widget _test() {
    return jikeWidget();
    // return otherWidget()
  }

  Widget jikeWidget() {
    // return CommonPage();
    // return CustomUIPage();
    // return GesturePage();
    // return DataTransPage();
    // return RouteWidget();
    return NativeMethodLessWidget();
  }

  Widget otherWidget() {
    return ListViewPage();
    // return ScrollViewPage();
    // return ContainerPage();
  }
}
