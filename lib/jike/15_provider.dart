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
        // ChangeNotifierProvider.value(value: CounterModel()), // 尽可能少使用.value的方法
      ],
      child: bodyPage(),
    );
  }
}

class bodyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ProviderPage bodyPage build");
    return DefaultTabController(
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
            Tab(icon: Icon(Icons.home),text: "Consumer",),
            Tab(icon: Icon(Icons.rss_feed),text: "Provider",),
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

class CounterModel with ChangeNotifier {
  int _count = 0;

  int get counter => _count;

  void addCounter() {
    _count++;
    notifyListeners();
    print("ProviderPage CounterModel addCounter");
  }
}

// -------------------------------------

class ConsumerTabPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("ProviderPage ConsumerTabPage1 build start");
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<double>(context);
    print("ProviderPage ConsumerTabPage1 build end");
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer2<CounterModel,double>(
                builder: (context, CounterModel counter, double textSize, _) => Text(
                    'Counter: ${counter.counter}',
                    style: TextStyle(fontSize: textSize))
            ),
            Consumer<CounterModel>(
              builder: (_context, CounterModel counter, child) => RaisedButton(
                onPressed: counter.addCounter,
                child: child,
              ),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => ConsumerTabPage2(context))),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ConsumerTabPage2 extends StatelessWidget {
  BuildContext _context;

  ConsumerTabPage2(this._context);

  @override
  Widget build(BuildContext context) {
    print("ProviderPage ConsumerTabPage2 build start");
    CounterModel _counter = _context.read<CounterModel>();
    double textSize = _context.read<double>();
    print("ProviderPage ConsumerTabPage2 build end");
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Text(
        'Counter: ${_counter.counter}',
        style: TextStyle(fontSize: textSize),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _counter.addCounter()),
    );
  }
}

// -------------------------------------

class ProviderTabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ProviderPage ProviderTabPage1 build start");
    CounterModel _counter = Provider.of<CounterModel>(context,listen: false);
    double textSize = Provider.of<double>(context,listen: false);
    print("ProviderPage ProviderTabPage1 build end");
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Counter: ${_counter.counter}',
              style: TextStyle(fontSize: textSize),
            ),
            RaisedButton(
                child: Icon(Icons.add),
                onPressed: () => _counter.addCounter()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProviderTabPage2(context: context,))),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ProviderTabPage2 extends StatefulWidget {
  BuildContext context;

  ProviderTabPage2({Key? key,required this.context}) : super(key: key);

  @override
  State<ProviderTabPage2> createState() => _ProviderTabPage2State();
}

class _ProviderTabPage2State extends State<ProviderTabPage2> {
  @override
  Widget build(BuildContext context) {
    print("ProviderPage _ProviderTabPage2State build start");
    // 刷新也是刷新绑定的context类，其余类仅仅是获取数据，不做刷新操作
    // CounterModel _counter = Provider.of<CounterModel>(widget.context,listen: true);
    // double textSize = Provider.of<double>(widget.context,listen: true);
    CounterModel _counter = widget.context.watch<CounterModel>();
    double textSize = widget.context.watch<double>();
    print("ProviderPage _ProviderTabPage2State build end");
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Text(
        'Counter: ${_counter.counter}',
        style: TextStyle(fontSize: textSize),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _counter.addCounter();
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


