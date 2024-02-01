import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/counter_controller.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (BuildContext context) => CounterProvider(),
        child: Counter_Provider_Ex()),
  ));
}

class Counter_Provider_Ex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counterController = Provider.of<CounterProvider>(context);//doubt
    return Scaffold(
        appBar: AppBar(
          title: Text("Provider_EX"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Incremnet counter",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Counter value:${counterController.counter_value.value}",//doubt
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(onPressed: () {
                  counterController.increment_Count();
                }, child: Text("Incfement value"))
              ],
            ),
            ),
        );
    }
}
