import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PerformancePage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PerformancePage(),

      // 性能检测
      checkerboardOffscreenLayers: true,// 检测是否存在多视图叠加，频繁的刷新问题
      checkerboardRasterCacheImages: true,// 检测静态图像是否没有缓存，导致构建耗费资源
    );
  }
}

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  String generateMd5(String data) {
    //MD5固定算法
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('demo')),
      body: Column(
        children: [
          RepaintBoundary(
              //设置静态缓存图像
              child: Center(
            child: Container(
              color: Colors.black,
              height: 10.0,
              width: 10.0,
            ),
          )),


          ListView.builder(
              itemCount: 30, // 列表元素个数
              itemBuilder: (context, index) {
                //反复迭代计算MD5
                String str = '1234567890abcdefghijklmnopqrstuvwxyz';
                for (int i = 0; i < 10000; i++) {
                  str = generateMd5(str);
                }
                return ListTile(
                    title: Text("Index : $index"), subtitle: Text(str));
              }
              // 列表项创建方法
              )
        ],
      ),
    );
  }
}
