import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'entity/student_entity.dart';


class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NetworkPage"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              child: Text('HttpClient demo'),
              onPressed: ()=>httpClient_demo(),
            ),
            MaterialButton(
              child: Text('http demo'),
              onPressed: ()=>http_demo(),
            ),
            MaterialButton(
              child: Text('Dio demo'),
              onPressed: ()=>dio_demo(),
            ),
            MaterialButton(
              child: Text('Dio 并发demo'),
              onPressed: ()=>dio_parse(),
            ),
            MaterialButton(
              child: Text('Dio 拦截'),
              onPressed: ()=>dio_intercept_reject(),
            ),
            MaterialButton(
              child: Text('Dio 缓存'),
              onPressed: ()=>dio_intercept_cache(),
            ),
            MaterialButton(
              child: Text('Dio 自定义header'),
              onPressed: ()=>dio_intercept_header(),
            ),
            MaterialButton(
              child: Text('JSON解析demo'),
              onPressed: ()=>jsonParse(),
            )
          ],
        ),
      ),
    );
  }

  void httpClient_demo() async {
    try {
      var httpClient = HttpClient();
      httpClient.idleTimeout = Duration(seconds: 5);
      var uri = Uri.parse("https://flutter.dev");
      var request = await httpClient.getUrl(uri);
      request.headers.add("user-agent", "Custom-UA");
      var response = (await request.close()) as HttpClientResponse;

      print('httpClient Respone code: ${response.statusCode}');
      print('httpClient Respone transform: ${await response.transform(utf8.decoder).join()}');
    } catch (e) {
      print(e);
    }
  }

  void http_demo() async {
    try {
      var client = http.Client();
      var uri = Uri.parse("https://flutter.dev");
      http.Response response =
          await client.get(uri, headers: {"user-agent": "Custom-UA"});

      print('http Respone code: ${response.statusCode}');
      print('http Respone body: ${response.body}');
    } catch (e) {
      print(e);
    }
  }

  void dio_demo() async {
    try {
      Dio dio = new Dio();
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));

      print('dio Respone data: ${response.data.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void dio_parse() async {
    try {
      Dio dio = new Dio();
      List<Response> response = await Future.wait([
        dio.get("https://flutter.dev"),
        dio.get("https://pub.dev/packages/dio")
      ]);

      print('dio_Parse Respone1 data: ${response[0].toString()}');
      print('dio_Parse Respone2 data: ${response[1].toString()}');
    } catch (e) {
      print(e);
    }
  }

  void dio_intercept_reject() async {
    try {
      Dio dio = new Dio();
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options,
          RequestInterceptorHandler handler) {
            return handler.reject(DioError(
                requestOptions: options,
                error:"Error：拦截的原因",));
      }));
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));

      print('dio_intercept_reject Respone data: ${response.data.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void dio_intercept_cache() async {
    try {
      Dio dio = new Dio();
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options,
          RequestInterceptorHandler handler) {
        return handler.resolve(Response(
            requestOptions: options,
            data: "返回缓存数据",));
      }));
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));

      print('dio_intercept_cache Respone data: ${response.data.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void dio_intercept_header() async {
    try {
      Dio dio = new Dio();
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options,
          RequestInterceptorHandler handler) {
        options.headers["user-agent"] = "Custom-UA";
        return handler.next(options);
      }));
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));

      print('dio_intercept_header Respone data: ${response.data.toString()}');
    } catch (e) {
      print(e);
    }
  }


  String jsonString = '''
    {
      "id":"123",
      "name":"张三",
      "score" : 95,
      "teacher": 
         {
           "name": "李四",
           "age" : 40
         }
    }
    ''';

  // 必须是静态方法，否则报错
  // Illegal argument in isolate message: (object extends NativeWrapper - Library:'dart:ui' Class: Path)
  static StudentEntity parseStudent(String content) {
    return StudentEntity.fromJson(json.decode(content));
  }

  Future<StudentEntity> loadStudent(){
    return compute(parseStudent,jsonString);
  }

  void jsonParse() {
    loadStudent().then((response) {
      print('response ${response.toString()}');
    });
  }
}