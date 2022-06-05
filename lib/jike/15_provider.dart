import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:ui';


class ProviderPage extends StatelessWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: 30.0),
        ChangeNotifierProvider<CounterModel>(
          create: (_) => CounterModel(),
        ),
        // ChangeNotifierProvider.value(value: CounterModel()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              ConsumerTabPage1(),
              ProviderTabPage1(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Consumer",
              ),
              Tab(
                icon: Icon(Icons.rss_feed),
                text: "Provider",
              ),
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
        ),
      ),
    );
  }
}

class CounterModel with ChangeNotifier {
  int _count = 0;

  int get counter => _count;

  void addCounter() {
    _count++;
    notifyListeners();
  }
}

// -------------------------------------

class ConsumerTabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<double>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Text(
          'Counter: ${_counter.counter}',
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ConsumerTabPage2())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ConsumerTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context, listen: false);
    final textSize = Provider.of<double>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Text('Counter: ${_counter.counter}',
          style: TextStyle(fontSize: textSize)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.addCounter(),
        child: Icon(Icons.add),
      ),
      // floatingActionButton: Consumer<CounterModel>(
      //   builder: (context, CounterModel counter, child) => FloatingActionButton(
      //     onPressed: () => counter.addCounter(),
      //     child: child,
      //   ),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

// -------------------------------------

class ProviderTabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<double>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Text(
          'Counter: ${_counter.counter}',
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProviderTabPage2())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ProviderTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<double>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Text(
        'Counter: ${_counter.counter}',
        style: TextStyle(fontSize: textSize),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.addCounter(),
        child: Icon(Icons.add),
      ),
    );
  }
}
