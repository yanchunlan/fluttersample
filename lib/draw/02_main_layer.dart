import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 演示通过layer实现基本绘制
void main() {
  ui.window.onBeginFrame = beginFrame;

  // ui.window.onDrawFrame = () {
  //   ui.Scene scene = drawFrame();
  //   ui.window.render(scene);
  // };

  ui.window.scheduleFrame();
}

void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = ui.window.devicePixelRatio;

  ///创建一个画板
  final ui.PictureRecorder recorder = ui.PictureRecorder();

  ///基于画板创建一个 Canvas
  final ui.Canvas canvas = ui.Canvas(recorder);
  canvas.scale(devicePixelRatio, devicePixelRatio);

  var centerX = ui.window.physicalSize.width / 2.0;
  var centerY = ui.window.physicalSize.height / 2.0;

  ///画一个 100 的剧中蓝色
  canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 200, height: 100),
      new Paint()..color = Colors.blue);

  final ui.SceneBuilder sceneBuilder = ui.SceneBuilder();

  OffsetLayer rootLayer = new OffsetLayer();


  OffsetLayer offsetLayer = new OffsetLayer(offset: Offset(centerX, centerY));
  // OffsetLayer offsetLayer = new OffsetLayer(offset: Offset(0, 0));
  rootLayer.append(offsetLayer);

  PictureLayer pictureLayer = new PictureLayer(Rect.zero);
  pictureLayer.picture = recorder.endRecording();
  offsetLayer.append(pictureLayer);


  rootLayer.addToScene(sceneBuilder);

  ui.Scene scene = sceneBuilder.build();

  ui.window.render(scene);
}

ui.Scene drawFrame() {
  final double devicePixelRatio = ui.window.devicePixelRatio;

  ///创建一个画板
  final ui.PictureRecorder recorder = ui.PictureRecorder();

  ///基于画板创建一个 Canvas
  final ui.Canvas canvas = ui.Canvas(recorder);
  canvas.scale(devicePixelRatio, devicePixelRatio);

  var centerX = ui.window.physicalSize.width / 2.0;
  var centerY = ui.window.physicalSize.height / 2.0;

  ///画一个 100 的剧中蓝色
  canvas.drawRect(
      Rect.fromCenter(
          center: Offset.zero,
          width: 100,
          height: 100),
      new Paint()..color = Colors.blue);

  ///结束绘制
  final ui.Picture picture = recorder.endRecording();

  final ui.SceneBuilder sceneBuilder = ui.SceneBuilder()
    ..pushOffset(centerX, centerY + 300)
    ..addPicture(ui.Offset.zero, picture)
    ..pop();

  ui.Scene scene = sceneBuilder.build();
  return scene;
}