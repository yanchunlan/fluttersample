import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            NormalAnimateWidget(),
            BuilderAnimateWidget(),
            WidgetAnimateWidget(),
            Page1(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "普通动画",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "Builder动画",
            ),
            Tab(
              icon: Icon(Icons.perm_identity),
              text: "Widget动画",
            ),
            Tab(icon: Icon(Icons.message), text: 'hero动画')
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

// ----------------------- normal ----------------
class NormalAnimateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NormalAnimateState();
}

class _NormalAnimateState extends State<NormalAnimateWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation = Tween(begin: 50.0, end: 200.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Container(
      width: animation.value,
      height: animation.value,
      child: FlutterLogo(),
    ))));
  }

  @override
  void dispose() {
    controller.dispose();
  }
}

// ----------------------- builder ----------------
class BuilderAnimateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuilderAnimateState();
  }
}

class _BuilderAnimateState extends State<BuilderAnimateWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation = Tween(begin: 50.0, end: 200.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: AnimatedBuilder(
      animation: animation,
      child: FlutterLogo(),
      builder: (context, child) => Container(
        width: animation.value,
        height: animation.value,
        child: child,
        // child: FlutterLogo(), // 避免在动画中多次构建控件
      ),
    ))));
  }

  @override
  void dispose() {
    controller.dispose();
  }
}

// ----------------------- AnimatedWidget ----------------

class WidgetAnimateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WidgetAnimateWidgetState();
}

class _WidgetAnimateWidgetState extends State<WidgetAnimateWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation = Tween(begin: 50.0, end: 200.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: AnimatedLogo(
      animation: animation,
    )));
  }

  @override
  void dispose() {
    controller.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key? key,required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

// ----------------------- page ----------------


class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Page1'),),
        body: GestureDetector(
          child: Row(children: <Widget>[
            Hero(
                tag: 'hero',
                child: Container(
                    width: 100, height: 100,
                    child: FlutterLogo())
            ),
            Text('点击Logo查看Hero效果')
          ],),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Page2()));
          },
        )
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Page2'),),
        body: Hero(
            tag: 'hero',
            child: Container(
                width: 300, height: 300,
                child: FlutterLogo()
            ))

    );
  }
}
