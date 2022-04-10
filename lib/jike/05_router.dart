import 'package:flutter/material.dart';

class RouteWidget extends StatelessWidget {
  const RouteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      routes: {
        "second_page": (Context) => SecondPage(),
        "third_page": (Context) => ThirdPage(),
      },
      onUnknownRoute: (RouteSettings setting) =>
          MaterialPageRoute(builder: (context) => UnknownPage()),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _msg='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("_FirstPageState"),
      ),
      body: Column(
        children: [
          RaisedButton(
              child: Text('基本路由'),
              onPressed: () =>
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => SecondPage()
                      )
                  )
          ),
          RaisedButton(
              child: Text('命名路由'),
              onPressed: () => Navigator.pushNamed(context, "second_page")
          ),
          RaisedButton(
              child: Text('命名路由（参数&回调）$_msg'),
              onPressed: ()=> Navigator.pushNamed(context, "third_page",arguments: "hi").then<String?>((msg) {
              setState(() {
                _msg += msg as String;
              });
            }),
          ),
          RaisedButton(
              child: Text('命名路由异常处理'),
              onPressed: () => Navigator.pushNamed(context,"unknown_page")
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondPage"),
      ),
      body: RaisedButton(
          child: Text('Back to first screen'),
          onPressed: () => Navigator.pop(context)
      ),
    );
  }
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UnknownPage"),
      ),
      body: RaisedButton(
          child: Text('Back to first screen'),
          onPressed: () => Navigator.pop(context)
      ),
    );
  }
}


class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg = ModalRoute.of(context)?.settings?.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("ThirdPage"),
      ),
      body: RaisedButton(
          child: Text('Back to first screen $msg'),
          onPressed: () => Navigator.pop(context, "Hi")
      ),
    );
  }
}


