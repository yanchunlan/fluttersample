import 'package:flutter/material.dart';
import 'gradient_linear_progressbar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Progress",
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: _Progress(),
      ),
    );
  }

  Widget _Progress() {
    return Container(
      margin: EdgeInsetsDirectional.all(30),
      child: Column(
        children: [
          // 方案1，设置外部圆角，缺点：内部还是直角
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
                minHeight: 12,
                value: 0.4,
                backgroundColor: Color(0xFFC3B9DE),
                valueColor: AlwaysStoppedAnimation(Color(0xFF4AE584))),
          ),

          SizedBox(height: 10),
          // 方案2，直接2个圆角矩形背景重叠
          Stack(
            children: [
              // 主背景
              Container(
                height: 20,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFF7E7F88).withOpacity(0.15),
                ),
              ),
              // 进度条背景
              Container(
                height: 20,
                width: 150, // 动态更改进度条盒子的宽度即可
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFFD785D),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          // 方案3，自定义控件，绘制
          Container(
            padding: EdgeInsetsDirectional.only(
                start: 20, top: 10, end: 20, bottom: 10),
            margin: EdgeInsetsDirectional.only(top: 10, bottom: 10),
            child: Row(
              children: [
                SizedBox(width: 40,),
                Expanded(
                  child: GradientLinearProgressBar(
                    strokeCapRound: true,
                    strokeWidth: 12,
                    colors: [Color(0xFFEE9755), Color(0xFFF0AD65)],
                    backgroundColor: Color(0xFFC3B9DE),
                    value: 30 / 100,
                  ),
                ),
                SizedBox(width: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
