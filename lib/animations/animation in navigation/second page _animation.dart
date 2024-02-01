import 'package:flutter/material.dart';

class Second_page extends StatelessWidget {
  const Second_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            }, child: Text("go back to main page")),
      ),
    );
  }
}
