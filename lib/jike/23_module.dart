import 'package:flutter/material.dart';
import 'package:flutter_reflect_module/reflect_page.dart';
import 'package:flutter_network_module/network_page.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ModulePage"),
        ),
        body: Container(
          child: Column(
            children: [

              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => NetworkPage()
                      )
                  );
                },
                child: Text("to NetworkPage"),
              ),

              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => ReflectPage()
                      )
                  );
                },
                child: Text("to ReflectPage"),
              ),

            ],
          ),
        ));
  }
}
