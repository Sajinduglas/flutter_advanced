import 'package:flutter/material.dart';

class ScreenStateLess extends StatelessWidget {
  String name;
  int? phone;
   ScreenStateLess({super.key, required this.name,  this.phone });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(
          "wELcome to $name number $phone",style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
