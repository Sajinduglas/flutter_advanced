import 'package:flutter/material.dart';

class ScreenStateFull extends StatefulWidget {
  String name;
  int? phone;
   ScreenStateFull({super.key, required this.name ,  this.phone });

  @override
  State<ScreenStateFull> createState() => _ScreenStateFullState();
}

class _ScreenStateFullState extends State<ScreenStateFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "${widget.name},\n${widget.phone}"
        ),
      ),
    );
  }
}
