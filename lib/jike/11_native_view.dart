import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class NativeViewPage extends StatefulWidget {
  const NativeViewPage({Key? key}) : super(key: key);

  @override
  State<NativeViewPage> createState() => _NativeViewPageState();
}

class _NativeViewPageState extends State<NativeViewPage> {
  late NativeViewController controller;

  @override
  void initState() {
    controller = NativeViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(title: Text("NativeViewPage")),
      body: Center(
        child: Container(
            width: 200, height: 200, child: SampleView(controller: controller)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.change_history),
        onPressed: () => controller.changeBackgroundColor(),
      ),
    );
  }
}

class SampleView extends StatefulWidget {
  final NativeViewController controller;

  const SampleView({Key? key,required this.controller}) : super(key: key);

  @override
  State<SampleView> createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'SampleView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return UiKitView(
        viewType: 'SampleView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
  }

  _onPlatformViewCreated(int id) => widget.controller.onCreate(id);
}

class NativeViewController {
  late MethodChannel _channel;

  onCreate(int viewIds) {
    _channel = MethodChannel('example.native_method/native_views_$viewIds');
  }

  changeBackgroundColor() async {
    _channel.invokeMethod('changeBackgroundColor');
  }
}
