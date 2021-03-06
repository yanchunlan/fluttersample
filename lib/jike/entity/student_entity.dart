import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

// import 'package:fluttersample/generated/json/base/json_field.dart';
// import 'package:fluttersample/generated/json/student_entity.g.dart';

@JsonSerializable()
class StudentEntity {
  String? id;
  String? name;
  int? score;
  StudentTeacher? teacher;

  // StudentEntity();

  // factory StudentEntity.fromJson(Map<String, dynamic> json) => $StudentEntityFromJson(json);

  // Map<String, dynamic> toJson() => $StudentEntityToJson(this);

  StudentEntity({this.id, this.name, this.score, this.teacher});

  factory StudentEntity.fromJson(Map<String, dynamic> parsedJson) {
    var teacher = null;
    if (parsedJson.containsKey('teacher')) {
      teacher = StudentTeacher.fromJson(parsedJson['teacher']);
    }
    return StudentEntity(
        id: parsedJson['id'],
        name: parsedJson['name'],
        score: parsedJson['score'],
        teacher: teacher);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['score'] = score;
    if (teacher != null) {
      map['teacher'] = teacher;
    }
    return map;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StudentTeacher {
  String? name;
  int? age;

  // StudentTeacher();

  // factory StudentTeacher.fromJson(Map<String, dynamic> json) => $StudentTeacherFromJson(json);

  // Map<String, dynamic> toJson() => $StudentTeacherToJson(this);

  StudentTeacher({this.name, this.age});

  factory StudentTeacher.fromJson(Map<String, dynamic> parsedJson) {
    return StudentTeacher(name: parsedJson['name'], age: parsedJson['age']);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'name': name,
        'age': age,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
