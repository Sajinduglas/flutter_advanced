import 'package:flutter/material.dart';
import 'package:flutter_advanced/passing%20data%20btw%20screens/to%20statefull/StateFullScreen.dart';
import 'package:flutter_advanced/passing%20data%20btw%20screens/to%20stateless/StatelessScreen.dart';

void main() {
  runApp(MaterialApp(
    home: DtaHome(),
  ));
}

class DtaHome extends StatelessWidget {
  DtaHome({super.key});

  String name = "sajin";
  int phone = 8136855126;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data passing"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenStateLess(name: name, phone: phone)));
              },
              child: Text("To stateless screen")),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ScreenStateFull(name: name, phone: phone)));
          }, child: Text("To statefull screen")),
        ],
      ),
    );
  }
}
