import 'package:flutter/material.dart';
import 'datetime_extension.dart';
import 'common_loading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TestPage"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text(),
                ElevatedButton(onPressed: () => {
                CommonLoading.show (status: "ing", indicator: Text(""), maskType: EasyLoadingMaskType.custom, dismissOnTap: true)
                }, child: Text("show")),
                ElevatedButton(onPressed: () => {CommonLoading.dismiss()},
                    child: Text("dismiss")),
              ],
            )));
  }

  Text _text() {
    return Text("test \n "
        "\ntoUtc+12 ${DateTime.now().toUtc()
        .add(new Duration(hours: 12))
        .toyyyyMMddHHmmss()}"
        "\ntoUtc+8  ${DateTime.now().toUtc()
        .add(new Duration(hours: 8))
        .toyyyyMMddHHmmss()}"
        "\ntoUtc    ${DateTime.now().toUtc().toyyyyMMddHHmmss()}"
        "\nnow      ${DateTime.now().toyyyyMMddHHmmss()}"
        "");
  }

  @override
  void initState() {
    EasyLoading.init();
  }
}
