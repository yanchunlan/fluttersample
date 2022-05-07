import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttersample/utils/timeUtils.dart';

const platform = MethodChannel('example.native_method/navigation');

class NativeMethodLessWidget extends StatelessWidget {
  const NativeMethodLessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(title: Text("Default Page")),
      body: Center(
          child: Column(
            children: [
              RaisedButton(
                  child: Text("打开应用商店"),
                  onPressed: () {
                    platform.invokeMethod('openAppStore');
                  }),
              RaisedButton(
                  child: Text("获取map"),
                  onPressed: () {
                    testGetTime();
                  }),
              RaisedButton(
                  child: Text("获取boolean"),
                  onPressed: () {
                    testGetBool();
                  }),
              RaisedButton(
                  child: Text("跳转second"),
                  onPressed: () {
                    testJumpSecondActivity();
                  }),
            ],
          )),
    );
  }

  void testGetTime(){
    TimeUtils.getStartTime().then((Map<dynamic,dynamic>? map){
      if (map!=null) {
        map['flutter_main_start_time']=TimeUtils.flutter_main_start_time;
        map['flutter_main_cost_time']=TimeUtils.flutter_main_cost_time;
        map['flutter_app_init_start_time']=TimeUtils.flutter_app_init_start_time;
        map['flutter_app_init_cost_time']=TimeUtils.flutter_app_init_cost_time;
        print("TimeUtils.getStartTime().then map ${map.toString()}");
      }else{
        print("TimeUtils.getStartTime().then map null");
      }
    });
  }

  void testGetBool() async {
    dynamic value = await TimeUtils.isStartUpPref();
    print("TimeUtils.testGetBool  $value");
  }

  void testJumpSecondActivity() async {
    TimeUtils.isJumpSecondActivity();
    print("TimeUtils.testJumpSecondActivity");
  }
}
