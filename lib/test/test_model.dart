import 'package:test_meta_data/test_meta_data.dart';
import 'package:json_annotation/json_annotation.dart';

/// source_gen 代码生成。具体参考 json_serializable
@TestMetadata()
class TestModel{
  late String name;
  late int age;
}

// part 'test_model.g.dart'; //这里报错没关系

@JsonSerializable()
class Person {
  final String name;
}

