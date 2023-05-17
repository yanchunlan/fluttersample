import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class CustomUIPage extends StatefulWidget {
  const CustomUIPage({Key? key}) : super(key: key);

  @override
  _CustomUIPageState createState() => _CustomUIPageState();
}

class _CustomUIPageState extends State<CustomUIPage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.update),
              text: "组合",
            ),
            Tab(
              icon:  Icon(Icons.cake),
              text: "自绘",
            ),
          ],
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView(
            children: [
              UpdatedItemWidget(
                  model:UpdatedItemModel(
                      appIcon: "assets/img/ic_launcher.png",
                      appDescription:
                      "Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
                      appName: "Google Maps - Transit & Fond",
                      appSize: "137.2",
                      appVersion: "Version 5.19",
                      appDate: "2019年6月5日"),
                  onPressed: (){
                    Fluttertoast.showToast(msg: "click");
                  },)
            ],
          ),
          Center(child:CustomUI(),)
        ],
      ),
    );
  }
}

class UpdatedItemModel {
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;

  UpdatedItemModel({required this.appIcon,
    required this.appName,
    required this.appSize,
    required this.appDate,
    required this.appDescription,
    required this.appVersion});
}

class UpdatedItemWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final UpdatedItemModel model;

  UpdatedItemWidget({Key? key,required this.model,required this.onPressed,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTopRow(context),
        buildBottomRow(context)
      ],
    );
  }

  //创建上半部分
  Widget buildTopRow(BuildContext context) {
    return Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(model.appIcon, width: 80, height: 80)
              )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.appName, maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Color(0xFF8E8D92)),),
                Text("${model.appDate}", maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Color(0xFF8E8D92)),),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: MaterialButton(
              color: Color(0xFFF1F0F7),
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              child: Text("OPEN", style: TextStyle(
                  color: Color(0xFF007AFE), fontWeight: FontWeight.bold),),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: onPressed,
            ),
          )
        ]);
  }

  //创建下半部分
  Widget buildBottomRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model.appDescription),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("${model.appVersion} • ${model.appSize} MB")
              )
            ]
        )
    );
  }
}

class CustomUI extends StatelessWidget {
  const CustomUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200,200),
      painter: WheelPainter(),
    );
  }



}
class WheelPainter extends CustomPainter{

  //设置画笔颜色
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }


  // 6等分的园
  @override
  void paint(Canvas canvas, Size size) {
    //饼图尺寸
    double wheelSize = min(size.width, size.height)/2;
    double nbElem = 6;
    double radius = (2 * pi) / nbElem;
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);

    //画圆弧，每次1/6个圆弧
    canvas.drawArc(boundingRect, 0, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(boundingRect, radius, radius, true, getColoredPaint(Colors.black38));
    canvas.drawArc(boundingRect, radius * 2, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(boundingRect, radius * 3, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(boundingRect, radius * 4, radius, true, getColoredPaint(Colors.blue));
    canvas.drawArc(boundingRect, radius * 5, radius, true, getColoredPaint(Colors.pink));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate !=this;
  }
}



