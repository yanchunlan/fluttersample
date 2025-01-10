import 'package:fluttersample/generated/json/base/json_convert_content.dart';
import 'package:fluttersample/jike/entity/student_entity.dart';
import 'package:json_annotation/json_annotation.dart';


StudentEntity $StudentEntityFromJson(Map<String, dynamic> json) {
	final StudentEntity studentEntity = StudentEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		studentEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		studentEntity.name = name;
	}
	final int? score = jsonConvert.convert<int>(json['score']);
	if (score != null) {
		studentEntity.score = score;
	}
	final StudentTeacher? teacher = jsonConvert.convert<StudentTeacher>(json['teacher']);
	if (teacher != null) {
		studentEntity.teacher = teacher;
	}
	return studentEntity;
}

Map<String, dynamic> $StudentEntityToJson(StudentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['score'] = entity.score;
	data['teacher'] = entity.teacher?.toJson();
	return data;
}

StudentTeacher $StudentTeacherFromJson(Map<String, dynamic> json) {
	final StudentTeacher studentTeacher = StudentTeacher();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		studentTeacher.name = name;
	}
	final int? age = jsonConvert.convert<int>(json['age']);
	if (age != null) {
		studentTeacher.age = age;
	}
	return studentTeacher;
}

Map<String, dynamic> $StudentTeacherToJson(StudentTeacher entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['age'] = entity.age;
	return data;
}