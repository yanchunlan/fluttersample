library test_meta_data;

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class TestMetadata {
  const TestMetadata();
}

class TestGenerator extends GeneratorForAnnotation<TestMetadata> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    /// 生成以下代码
    return "class Tessss{}";
  }
}

