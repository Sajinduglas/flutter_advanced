import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: mainPageMedia(),
  ));
}

class mainPageMedia extends StatelessWidget {
  const mainPageMedia({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: width > 600 ? Bigscreen() : Mobilescreen(),
    );
  }
}

class Bigscreen extends StatelessWidget {
  const Bigscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("big screen"),
        backgroundColor: Colors.red,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.pinkAccent,
                                child: Text("Video $index"),
                              ),
                            )))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.blue,
                          child: Text("Video $index"),
                        ),
                      )))
        ],
      ),
    );
  }
}

class Mobilescreen extends StatelessWidget {
  const Mobilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile screen "),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(color: Colors.red),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(

                          color: Colors.blue,
                          child: Text("Video $index"),
                        ),
                      )))
        ],
      ),
    );
  }
}
