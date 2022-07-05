import 'dart:ui';
import 'package:flutter/scheduler.dart';

// 原始fps回调
var originalCallback;

const maxFrames = 25;
final List<FrameTiming> lastFrames = <FrameTiming>[];
const frameInterval = const Duration(microseconds: Duration.microsecondsPerSecond ~/ 60);

void startFpsListener() {
  SchedulerBinding.instance?.addTimingsCallback(onReportTimings);
}

void stopFpsListener() {
  SchedulerBinding.instance?.removeTimingsCallback(onReportTimings);
}

// 拦截 window.onReportTimings
void onReportTimings(List<FrameTiming> timings) {
  lastFrames.addAll(timings);
  if (lastFrames.length > maxFrames) {
    lastFrames.removeRange(0, lastFrames.length - maxFrames);
  }
  if (originalCallback != null) {
    originalCallback(timings);
  }
  print("fps $fps");
}

// 页面帧率
double get fps {
  int sum = 0;
  for (FrameTiming timings in lastFrames) {
    int duration = timings.timestampInMicroseconds(FramePhase.rasterFinish) -
        timings.timestampInMicroseconds(FramePhase.buildStart);

    if (duration < frameInterval.inMicroseconds) {
      sum += 1;
    } else {
      int count =
          (duration / frameInterval.inMicroseconds).ceil(); // 返回不小于此数字的最小整数
      sum += count;
    }
  }
  return lastFrames.length / sum * 60;
}
