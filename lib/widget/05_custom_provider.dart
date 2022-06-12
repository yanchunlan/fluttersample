import 'package:flutter/material.dart';

/**
 * 自定义provider
 */
class CustomProviderPage extends StatefulWidget {
  const CustomProviderPage({Key? key}) : super(key: key);

  @override
  State<CustomProviderPage> createState() => _CustomProviderPageState();
}

class _CustomProviderPageState extends State<CustomProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModelProviderWidget<CountModel>(
        data: CountModel(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CountModel>(
                builder: (context, value) => Text("count ${value.count}")),
            Builder(
              builder: ((context) {
                print("RaisedButton build");
                return RaisedButton(
                  child: Text("add"),
                  onPressed: () => ModelProviderWidget.of<CountModel>(
                      context, listen: false).increment(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- 自定义provider ------------------------

class ProviderInheritedWidget<T> extends InheritedWidget {
  final T data;
  final Widget child;

  ProviderInheritedWidget({required this.data,required this.child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}


class NotifyModel implements Listenable {

  List _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    _listeners.forEach((element) {
      element();
    });
  }
}


class CountModel extends NotifyModel {

  int count = 0;

  CountModel();

  void increment() {
    count++;
    notifyListeners();
  }
}


class ModelProviderWidget<T extends NotifyModel> extends StatefulWidget {
  final T data;
  final Widget child;

  ModelProviderWidget({Key? key,required this.data,required this.child})
      : super(key: key);

  static T of <T>(BuildContext context, {bool listen = true}) {
    dynamic r =  (/*listen ?*/ context.dependOnInheritedWidgetOfExactType<ProviderInheritedWidget<T>>() /*:
    (context.getElementForInheritedWidgetOfExactType<ProviderInheritedWidget<T>>()?.widget
    as ProviderInheritedWidget<T>)*/)?.data;
    return r(T);
  }

  @override
  State<ModelProviderWidget<T>> createState() => _ModelProviderWidgetState<T>();
}

class _ModelProviderWidgetState<T extends NotifyModel>
    extends State<ModelProviderWidget<T>> {

  void notify() {
    setState(() {
      print("setState");
    });
  }

  @override
  void initState() {
    widget.data.addListener(notify);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(notify);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderInheritedWidget<T>(data: widget.data, child: widget.child,);
  }


  @override
  void didUpdateWidget(ModelProviderWidget<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(notify);
      widget.data.addListener(notify);
    }
    super.didUpdateWidget(oldWidget);
  }
}

class Consumer<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;

  Consumer({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Consumer build");
    return builder(context, ModelProviderWidget.of<T>(context));
  }
}


// ---------------------- 自定义provider ------------------------ {

