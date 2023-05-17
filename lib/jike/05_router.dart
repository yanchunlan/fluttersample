import 'package:flutter/material.dart';

class RouteWidget extends StatelessWidget {
  const RouteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      routes: {
        "second_page": (Context) => SecondPageRouter(),
        "third_page": (Context) => ThirdPageRouter(),
      },
      onUnknownRoute: (RouteSettings setting) =>
          MaterialPageRoute(builder: (context) => UnknownPage()),
      home: FirstPageRouter(),
    );
  }
}

class FirstPageRouter extends StatefulWidget {
  const FirstPageRouter({Key? key}) : super(key: key);

  @override
  createState() => _FirstPageRouterState();
}

class _FirstPageRouterState extends State<FirstPageRouter> {
  String _msg='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("_FirstPageState"),
      ),
      body: Column(
        children: [
          MaterialButton(
              child: Text('基本路由'),
              onPressed: () =>
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => SecondPageRouter()
                      )
                  )
          ),
          MaterialButton(
              child: Text('命名路由'),
              onPressed: () => Navigator.pushNamed(context, "second_page")
          ),
          MaterialButton(
              child: Text('命名路由（参数&回调）$_msg'),
              onPressed: ()=> Navigator.pushNamed(context, "third_page",arguments: "hi").then<String?>((msg) {
              setState(() {
                _msg += msg as String;
              });
            }),
          ),
          MaterialButton(
              child: Text('命名路由异常处理'),
              onPressed: () => Navigator.pushNamed(context,"unknown_page")
          ),
        ],
      ),
    );
  }
}

class SecondPageRouter extends StatelessWidget {
  const SecondPageRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondPage"),
      ),
      body: MaterialButton(
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
      body: MaterialButton(
          child: Text('Back to first screen'),
          onPressed: () => Navigator.pop(context)
      ),
    );
  }
}


class ThirdPageRouter extends StatelessWidget {
  const ThirdPageRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg = ModalRoute.of(context)?.settings?.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("ThirdPage"),
      ),
      body: MaterialButton(
          child: Text('Back to first screen $msg'),
          onPressed: () => Navigator.pop(context, "Hi")
      ),
    );
  }
}


