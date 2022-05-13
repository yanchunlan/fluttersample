import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Container",
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: _container(),
      ),
    );
  }

  Container _container() {
    return Container(
      // constraints 改变Container 的属性
      constraints: BoxConstraints.expand(
        width: 200,
        height: 200,
      ),
      // 在这里尝试 Container 属性效果
      // color: Colors.lightBlue,
      width: 300,

      margin: const EdgeInsets.only(left: 50, top: 20, right: 30),
      // 边框
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 3, color: Colors.cyan),
          left: BorderSide(width: 3, color: Colors.black),
          right: BorderSide(width: 3, color: Colors.red),
          bottom: BorderSide(width: 3, color: Colors.yellow),
        ),

        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(0),
        //   bottomLeft: Radius.circular(30),
        //   bottomRight: Radius.circular(30),
        // ),

        // 渐变色
        gradient: LinearGradient(
            colors: [Colors.white, Colors.yellow],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(0, 1)),

        // img
        image: DecorationImage(
            image: NetworkImage(
                'http://tiebapic.baidu.com/forum/w%3D580/sign=a96ca741eafaaf5184e381b7bc5594ed/7ea6a61ea8d3fd1f2643ad5d274e251f95ca5f38.jpg')),

        //
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(10, 10))],
      ),

      transform: Matrix4.rotationY(0.6),

      child: Container(
        child: StackDemo(),
      ),
    );
  }
}


class StackDemo extends StatelessWidget {
  const StackDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 78;
    double headSize = iconSize * 1.1;
    double overflow = -(headSize - iconSize) / 2;

    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.center,
      children: [

        IgnorePointer(
          child:  ClipOval(child: Image.asset('assets/img/ic_launcher.png',
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,),),
        ),

        PositionedDirectional(
          start: overflow,
          end: overflow,
          top: overflow,
          bottom: overflow,
          // width: iconSize + 7,
          // height: iconSize + 7,
          child: new IgnorePointer(
            child: new Container(
              // width: iconSize + 7,
              // height: iconSize + 7,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(iconSize/2),
                border: Border.all(color: Color(0xFFF7577F), width: 3.5),
              ),
            ),
          ),
        ),

        // PositionedDirectional(
        //   start: overflow,
        //   end: overflow,
        //   top: overflow,
        //   bottom: overflow,
        //   child: new IgnorePointer(
        //     child: new Container(
        //       width: headSize,
        //       height: headSize,
        //       decoration: new BoxDecoration(
        //         borderRadius: BorderRadius.circular(headSize/2),
        //         border: Border.all(color: Color(0xFFF7577F), width: 3.5),
        //       ),
        //     ),
        //   ),
        // ),

        // IgnorePointer(
        //   child: Container(
        //     padding: EdgeInsetsDirectional.all(3.5),
        //     decoration: BoxDecoration(
        //         border: Border.all(color: Color(0xFFF7577F), width: 3.5),
        //         borderRadius: BorderRadius.circular(80)),
        //   ),
        // ),

      ],
    );
  }
}

