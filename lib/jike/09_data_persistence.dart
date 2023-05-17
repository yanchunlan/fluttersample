import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'entity/student_entity.dart';

class PersistencePage extends StatefulWidget {
  const PersistencePage({Key? key}) : super(key: key);

  @override
  State<PersistencePage> createState() => _PersistencePageState();
}

class _PersistencePageState extends State<PersistencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PersistencePage"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              child: Text('文件 demo'),
              onPressed: () => fileDemo(),
            ),
            MaterialButton(
              child: Text('SharedPreference demo'),
              onPressed: () => spDemo(),
            ),
            MaterialButton(
              child: Text('数据库 demo'),
              onPressed: () => dbDemo(),
            )
          ],
        ),
      ),
    );
  }

  // ------------ file --------------
  void fileDemo() {
    _readFileContent().then((value) {
      print("fileDemo before:$value");
      _writeFileContent('$value value').then((_) {
        _readFileContent().then((value) {
          print("fileDemo after:$value");
        });
      });
    });
  }

  Future<File> get _localFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/content.txt');
  }

  Future<String> _readFileContent() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<File> _writeFileContent(String content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  // ------------ sp --------------
  void spDemo() {
    _readSPCounter().then((value) {
      print("spDemo before:$value");
      _writeSPCounter().then((_) {
        _readSPCounter().then((value) {
          print("spDemo after:$value");
        });
      });
    });
  }

  Future<SharedPreferences> get sp async {
    return await SharedPreferences.getInstance();
  }

  Future<int> _readSPCounter() async {
    final prefs = await sp;
    int counter = (prefs.getInt('counter') ?? 0);
    return counter;
  }

  Future<void> _writeSPCounter() async {
    final prefs = await sp;
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', counter);
  }

  // ------------ db --------------
  void dbDemo() async {
    int studentID = 123;
    var student1 = StudentEntity(id: '${++studentID}', name: '张三', score: 90);
    var student2 = StudentEntity(id: '${++studentID}', name: '李四', score: 80);
    var student3 = StudentEntity(id: '${++studentID}', name: '王五', score: 85);

    await insertStudent(student1);
    await insertStudent(student2);
    await insertStudent(student3);

    getStudents().then((list) =>
        list.forEach((s) {
          print('id:${s.id},name:${s.name}');
        }));
    final Database db = await database;
    db.close();
  }

  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'students_database.db'),
      onCreate: (db, version) =>
          db.execute(
              "CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"),
      onUpgrade: (db, oldVersion, newVersion) {
        print("old:$oldVersion,new:$newVersion");
      },
      version: 1,
    );
  }

  Future<void> insertStudent(StudentEntity std) async {
    final Database db = await database;
    await db.insert(
      'students',
      std.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StudentEntity>> getStudents() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) => StudentEntity.fromJson(maps[i]));
  }
}
