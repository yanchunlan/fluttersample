import 'package:flutter/material.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({Key? key}) : super(key: key);

  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("homepage"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _text(),
            _text2(),
            _image(),
            _button(),
          ],
        )));
  }

  Widget _button() {
    // return FloatingActionButton(
    //   onPressed: () => print('FloatingActionButton pressed'),
    //   child: Text('Btn'),
    // );

    // return FlatButton(
    //   onPressed: () => print('FlatButton pressed'),
    //   child: Text('Btn'),
    // );

    // return FlatButton(
    //   onPressed: () => print('MaterialButton pressed'),
    //   child: Text('Btn'),
    // );

    return MaterialButton(
      onPressed: () {
        print("点击了 button");
      },
      onLongPress: () {
        print("长按了 button");
      },
      onHighlightChanged: (bool b) {
        print(b ? "button 高亮了" : "button 不亮了");
      },
      color: Colors.blue,
      textColor: Colors.white,
      child: Container(
        height: 60,
        width: 200,
        child: Text('球场的'),
        alignment: Alignment.center,
      ),

      // shape: CircleBorder(
      //   side: BorderSide(
      //     width: 2,
      //     color: Colors.red,
      //     style: BorderStyle.solid,
      //     // style: BorderStyle.none,
      //   ),
      // ),
      shape: StadiumBorder(
        side: BorderSide(
          width: 2,
          color: Colors.red,
          style: BorderStyle.solid,
          // style: BorderStyle.none,
        ),
      ),
    );

    // 自定义样式
    // return FlatButton(
    //   color: Colors.red,
    //   shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   colorBrightness: Brightness.light,
    //   onPressed: () => print('MaterialButton pressed'),
    //   child: Row(
    //     // 满屏的列
    //     children: [
    //       Icon(Icons.add),
    //       Text('add'),
    //     ],
    //   ),
    // );
  }

  Widget _image() {
    return Image.asset('assets/img/ic_launcher.png');
    // return Image.network('http://xxx/xxx/test.gif');
    // return FadeInImage.assetNetwork(
    //   placeholder: 'assets/loading.gif',
    //   img: 'http://xxx/xxx/test.gif',
    //   fit: BoxFit.cover,
    //   width: 200,
    //   height: 200,
    // );
    // return CachedNetworkImage(
    //   width: 200,
    //   height: 200,
    //   fit: BoxFit.cover,
    //   imageUrl: 'http://xxx/xxx/test.gif',
    // );
  }

  Text _text2() {
    TextStyle blackStyle = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
        color: Colors.black); //黑色样式
    TextStyle redStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red); //红色样式
    return Text.rich(TextSpan(children: [
      TextSpan(text: "111", style: blackStyle),
      TextSpan(text: "222", style: redStyle),
      TextSpan(text: "333", style: blackStyle),
    ]));
  }

  Text _text() {
    return Text(
      "sssssssssssssssssss"
      "sd"
      "s"
      "s "
      "ssssss"
      "ssssaaaaaaaaaaaaaaassssaaaaaaaaaaaaaaassssaaaaaaaaaaaaaaassssaaaaaaaaaaaaaaassssaaaaaaaaaaaaaaa"
      "ssss"
      "count",
      // 测量行宽度
      textWidthBasis: TextWidthBasis.parent,
      textAlign: TextAlign.start,
      textDirection: TextDirection.rtl,
      maxLines: 2,
      softWrap: true,
      textScaleFactor: 1.0,
      semanticsLabel: "ssss",
      overflow: TextOverflow.visible,
      // 样式
      style: TextStyle(
          color: Colors.amberAccent,
          backgroundColor: Colors.red,
          fontSize: 26,
          decorationColor: Colors.yellow,
          // 下划线
          fontWeight: FontWeight.w900,
          //字体加粗
          letterSpacing: 1,
          // 字母间距
          debugLabel: "whiteCupertino labelLarge",
          // 仅在 debug 模式下有用
          shadows: [
            Shadow(color: Colors.brown),
            Shadow(color: Colors.red),
          ]),
    );
  }
}
