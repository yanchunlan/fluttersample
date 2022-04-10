import 'package:flutter/material.dart';

class Lifecycle extends StatefulWidget {
  const Lifecycle({Key? key}) : super(key: key);

  @override
  _LifecycleState createState() => _LifecycleState();
}

class _LifecycleState extends State<Lifecycle> with WidgetsBindingObserver{
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      print("单次Frame绘制回调");//只回调一次

    });
    WidgetsBinding.instance?.addPersistentFrameCallback((timeStamp) {
      print("实时Frame绘制回调");//每帧都回调

    });
  }

  @override
  void setState(VoidCallback fn) {}

  @override
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sss"),
      ),
      body: Center(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {}

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {

  }
}
