import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './../generated/l10n.dart';

void main() => runApp(LanguageApp());

class LanguageApp extends StatelessWidget {
  const LanguageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const{
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      },
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context){
        return S.current.app_title;
      },
      // 系统语言改变回调事件
      // localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
      //   return locale;
      // },
      // locale: ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LanguagePage(),
    );
  }
}


class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  int _counter = 0;

  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.main_title),
      ),

      body: Center(
          child: Column(
            children: <Widget>[
              Text(
                  S.current.message_tip(_counter)
              )
            ],
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //

    );
  }
}
