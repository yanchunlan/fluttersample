import 'package:flutter/material.dart';
import '19_multi_env.dart';

void main(){
  AppConfig config=AppConfig(
    appName: 'dev',//主页标题
    apiBaseUrl: 'http://dev.example.com/',//接口域名
    child: MultiEnvPage(),
  );
  runApp(config);
}