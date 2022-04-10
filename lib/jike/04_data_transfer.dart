import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'dart:async';

class DataTransPage extends StatelessWidget {
  const DataTransPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CounterPage(),
            NotificationWidget(),
            FirstPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: "InheritedWidget",),
            Tab(icon: Icon(Icons.rss_feed), text: "Notification",),
            Tab(icon: Icon(Icons.perm_identity), text: "EventBus",)
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}


class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void _incrementCounter() =>
      setState(() {
        count++;
      });

  @override
  Widget build(BuildContext context) {
    return CountContainer(
      model: this,
      increment: _incrementCounter,
      child: Counter(),
    );
  }
}

class CountContainer extends InheritedWidget {

  static CountContainer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CountContainer>();
  }

  final _CounterPageState model;

  final VoidCallback increment;

  CountContainer({
    Key? key,
    required this.model,
    required this.increment,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountContainer oldWidget) {
    return oldWidget.model != model;
  }
}

class Counter extends StatelessWidget {

  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountContainer? state = CountContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget demo"),
      ),
      body: Text(
        'You have pushed the button this many times: ${state?.model?.count}',
      ),
      floatingActionButton: FloatingActionButton(onPressed: state?.increment),

    );
  }
}

// ---------------------  2  ---------------------

class CustomNotification extends Notification {
  final String msg;

  CustomNotification(this.msg);

}

class CustomChild extends StatelessWidget {
  const CustomChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: ()=>CustomNotification("Hi").dispatch(context),
      child: Text("dispatch"),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget> {
  String _msg = "通知：";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<CustomNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "  ";
        });
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(_msg), CustomChild()],
      ),
    );
  }
}

// ---------------------  3  ---------------------

class CustomEvent {
  String msg;

  CustomEvent(this.msg);
}

EventBus eventBus = new EventBus();

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String msg = "通知：";
  StreamSubscription? subscription;

  @override
  void initState() {
    subscription = eventBus.on<CustomEvent>().listen((event) {
      print(event);
      setState(() {
        msg += event.msg;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page"),),
      body: Text(msg),
      floatingActionButton: FloatingActionButton(onPressed:
          () =>
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => SecondPage()))),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page"),),
      body: RaisedButton(
          child: Text('Fire Event'),
          onPressed: ()=> eventBus.fire(CustomEvent("hello"))
      ),
    );
  }
}

