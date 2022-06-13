import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String appName;
  final String apiBaseUrl;

  AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required Widget child,
  }) : super(child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

class MultiEnvPage extends StatelessWidget {
  const MultiEnvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(() {
      //Do sth for debug
      print('checking debug in assert ');
      return true;
    }());

    // if(kReleaseMode){
    //   //Do sth for release
    //   print('checking release from Environment ');
    // } else {
    //   //Do sth for debug
    //   print('checking debug from Environment ');
    // }

    AppConfig? config = AppConfig.of(context);
    return MaterialApp(
      title: config?.appName ?? "title",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiEnvHomePage(),
    );
  }
}

class MultiEnvHomePage extends StatelessWidget {
  const MultiEnvHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig? config = AppConfig.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(config?.appName ?? "title"),
      ),
      body: Center(
        child: Text('API host: ${config?.apiBaseUrl}'),
      ),
    );
  }
}
