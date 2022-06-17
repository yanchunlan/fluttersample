import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 有问题，没有接通
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "NotificationPage",
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: RaisedButton(
        onPressed: () {
          Future.delayed(Duration(seconds: 3), () {
            notification.send('title', 'body');
          });
        },
        child: Text('延时3s，发送通知'),
      ),
    );
  }

  @override
  void initState() {
    notification.init();
  }
}

/// 通知封装
/// author Shendi
class Notification {

  final FlutterLocalNotificationsPlugin np = FlutterLocalNotificationsPlugin();

  /// 是否初始化了
  var isInit = false;

  /// 初始化
  void init() {
    if (isInit) return;
    isInit = true;

    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = const IOSInitializationSettings();

    np.initialize(InitializationSettings(android: android, iOS: ios));
    print("NotificationPage init");
  }

  void send(String title, String body) {
    // 初始化
    init();

    // 构建描述
    var androidDetails = const AndroidNotificationDetails(
        'id描述',
        '名称描述',
        importance: Importance.max,
        priority: Priority.high
    );
    var iosDetails = const IOSNotificationDetails();
    var details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails
    );

    // 显示通知, 第一个参数是id,id如果一致则会覆盖之前的通知
    np.show(DateTime.now().millisecondsSinceEpoch >> 10, title, body, details);
    print("NotificationPage show");
  }

}
var notification = Notification();

