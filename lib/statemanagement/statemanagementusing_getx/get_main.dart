import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

void main() {
  runApp(MaterialApp(
    home: get_main(

    ),
  ));
}

class get_main extends StatelessWidget {
  const get_main({super.key});

  @override
  Widget build(BuildContext context) {
    final countcontroller controller = Get.put(countcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter_Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("Count is ${controller.count}")),
            ElevatedButton(onPressed: () {
              controller.incriment();
            }, child: Text("Incriment")),
            ElevatedButton(onPressed: () {
              controller.decriment();
            }, child: Text("Decriment"))
          ],
        ),
      ),
    );
  }
}
