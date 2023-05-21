import 'dart:ui';

import 'package:flutter/material.dart';

/// 演示通过picture实现基本绘制
void main() {
  PictureRecorder recorder = PictureRecorder();
  // 初始化 Canvas 时，传入 PictureRecorder 实例
  // 用于记录发生在该 canvas 上的所有操作
  //
  Canvas canvas = Canvas(recorder);

  Paint circlePaint= Paint();
  circlePaint.color = Colors.blueAccent;

  // 调用 Canvas 的绘制接口，画一个圆形
  //
  canvas.drawCircle(Offset(0, 0), 300, circlePaint);

  // 画一个矩形
  Rect rect = Rect.fromLTWH(0, 0, 50, 50);
  Paint rectPaint = Paint();
  rectPaint.color = Colors.red;
  canvas.drawRect(rect, rectPaint);

  // 绘制结束，生成Picture
  //
  Picture picture = recorder.endRecording();

  SceneBuilder sceneBuilder = SceneBuilder();
  sceneBuilder.pushOffset(800, 300);
  // 将 picture 送入 SceneBuilder
  //
  sceneBuilder.addPicture(Offset(100, 0), picture);
  sceneBuilder.pop();

  // 生成 Scene
  //
  Scene scene = sceneBuilder.build();

  window.onDrawFrame = () {
    // 将 scene 送入 Engine 层进行渲染显示
    //
    window.render(scene);
  };
  window.scheduleFrame();
}