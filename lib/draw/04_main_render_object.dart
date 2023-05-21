import 'dart:ui';

import 'package:flutter/rendering.dart';

/// 演示通过RenderObject实现基本绘制
void main(){

  PipelineOwner pipelineOwner = PipelineOwner();

  RenderView rv = RenderView(configuration: ViewConfiguration(
    size: window.physicalSize / window.devicePixelRatio,
    devicePixelRatio: window.devicePixelRatio,
  ), window: window);

  rv.attach(pipelineOwner);
  rv.prepareInitialFrame();

  RenderDecoratedBox rdb = RenderDecoratedBox(
      decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 255))
  );

  rv.child = rdb;

  window.onDrawFrame = (){
    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();
    rv.compositeFrame();
  };
  window.scheduleFrame();
}