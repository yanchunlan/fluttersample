import 'package:fluttersample/generated/json/base/json_convert_content.dart';
import 'package:fluttersample/test/test_model.dart';
import 'package:test_meta_data/test_meta_data.dart';

import 'package:json_annotation/json_annotation.dart';


Person $PersonFromJson(Map<String, dynamic> json) {
	final Person person = Person();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		person.name = name;
	}
	return person;
}

Map<String, dynamic> $PersonToJson(Person entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	return data;
}