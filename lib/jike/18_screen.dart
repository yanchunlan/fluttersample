import 'package:flutter/material.dart';


class ScreenPage extends StatelessWidget {
  const ScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            MasterDetailPage(),
            OrientationDemo(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: "多窗格",),
            Tab(icon: Icon(Icons.rss_feed), text: "转屏",),
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

// 横竖屏幕适配
class MasterDetailPage extends StatefulWidget {
  const MasterDetailPage({Key? key}) : super(key: key);

  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  var selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (MediaQuery
              .of(context)
              .size
              .width > 480)
            return Row(children: <Widget>[
              Expanded(
                child: ListWidget(itemSelectedCallback: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                }),
              ),
              Expanded(child: DetailWidget(selectedValue)),
            ]);
          return ListWidget(itemSelectedCallback: (value) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(),
                  body: DetailWidget(value),
                );
              },
            ));
          });
        },
      ),
    );
  }
}


class OrientationDemo extends StatefulWidget {
  @override
  _OrientationDemoState createState() => _OrientationDemoState();
}

class _OrientationDemoState extends State<OrientationDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildVerticalLayout()
              : _buildHorizontalLayout();
        },
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: <Widget>[
        PeopleIconView(),
        Expanded(
          child: ItemListView(),
        )
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: PeopleIconView()
          ),
          Expanded(
            child: ItemListView(),
          ),
        ],
      ),
    );
  }
}


class PeopleIconView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Icon(
        Icons.people_outline,
        size: 80.0,
      ),
    );
  }
}

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(30, (n) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Some text',
            style: TextStyle(fontSize: 25.0),
          ),
        );
      }),
    );
  }
}


// ------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------
typedef Null ItemSelectedCallback(int position);

class ListWidget extends StatefulWidget {
  final ItemSelectedCallback itemSelectedCallback;

  const ListWidget({Key? key,required this.itemSelectedCallback}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, position) {
        return ListTile(
          title: Text(position.toString()),
          onTap: () => widget.itemSelectedCallback(position),
        );
      },
    );
  }
}

class DetailWidget extends StatefulWidget {
  final int data;

  DetailWidget(this.data);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('index: ${widget.data}'),
          ],
        ),
      ),
    );
  }
}
