import 'package:flutter/material.dart';
import '20_multi_env.dart';

void main(){
  AppConfig config=AppConfig(
    appName: 'api',//主页标题
    apiBaseUrl: 'http://api.example.com/',//接口域名
    child: MultiEnvPage(),
  );
  runApp(config);
}