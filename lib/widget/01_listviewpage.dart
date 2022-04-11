import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  var list = [];

  @override
  void initState() {
    initData();
  }

  void initData() {
    list.add(
        {"name": "基础组件", "desc": "在构建您的第一个Flutter应用程序之前，您绝对需要了解这些widget。"});
    list.add({
      "name": "Material Components",
      "desc": "实现了Material Design 指南的视觉、效果、motion-rich的widget。"
    });
    list.add({
      "name": "Cupertino(iOS风格的widget)",
      "desc": "用于当前iOS设计语言的美丽和高保真widget。"
    });
    list.add({
      "name": "Layout",
      "desc": "排列其它widget的columns、rows、grids和其它的layouts。"
    });
    list.add({"name": "Text", "desc": "文本显示和样式。"});
    list.add({"name": "Assets、图片、Icons", "desc": "管理assets, 显示图片和Icon。"});
    list.add({
      "name": "Input",
      "desc": "Material Components 和 Cupertino中获取用户输入的widget。"
    });
    list.add({"name": "动画和Motion", "desc": "在您的应用中使用动画。查看Flutter中的动画总览。"});
    list.add({"name": "交互模型", "desc": "响应触摸事件并将用户路由到不同的页面视图（View）。"});
    list.add({"name": "样式", "desc": "管理应用的主题，使应用能够响应式的适应屏幕尺寸或添加填充。"});
    list.add({"name": "绘制和效果", "desc": "Widget将视觉效果应用到其子组件，而不改变它们的布局、大小和位置。"});
    list.add({"name": "Async", "desc": "Flutter应用的异步模型。"});
    list.add({"name": "滚动", "desc": "滚动一个拥有多个子组件的父组件。"});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("widget 目录"),
        ),
        body: Center(
          child: _buildListView3(),
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 140, //item延展尺寸(宽度)
        children: <Widget>[
          Container(color: Colors.black),
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.yellow),
          Container(color: Colors.orange),
        ]);
  }

  ListView _buildListView1() {
    return ListView(children: <Widget>[
      //设置ListTile组件的标题与图标
      ListTile(leading: Icon(Icons.map), title: Text('Map')),
      ListTile(leading: Icon(Icons.mail), title: Text('Mail')),
      ListTile(leading: Icon(Icons.message), title: Text('Message')),
    ]);
  }

  ListView _buildListView2() {
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: list.length,
        itemExtent: 100,
        itemBuilder: _itemBuilder);
  }

  ListView _buildListView3() {
    return ListView.separated(
        padding: const EdgeInsets.all(15.0),
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Divider(color: Colors.green)
            : Divider(
                color: Colors
                    .red), //index为偶数，创建绿色分割线；index为奇数，则创建红色分割线        itemBuilder: (context, index) {
        itemBuilder: _itemBuilder);
  }

  Widget _itemBuilder(context, index) {
    var func = list[index];
    return ListTile(
      contentPadding: const EdgeInsets.all(10.0),
      title: Text(
        "${func["name"]}",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "${func["desc"]}",
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        print("index $index ");
      },
    );
  }

  ListView _buildListView4() {
    return ListView.separated(
        padding: const EdgeInsets.all(15.0),
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Divider(color: Colors.green)
            : Divider(
                color: Colors
                    .red), //index为偶数，创建绿色分割线；index为奇数，则创建红色分割线        itemBuilder: (context, index) {
        itemBuilder: _itemBuilder);
  }
}
