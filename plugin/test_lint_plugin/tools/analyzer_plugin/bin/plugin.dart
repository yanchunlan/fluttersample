import 'dart:isolate';
import 'package:test_lint_plugin/start.dart';

void main(List<String> args, SendPort sendPort) {
  print("start");
  start(args, sendPort);
}
