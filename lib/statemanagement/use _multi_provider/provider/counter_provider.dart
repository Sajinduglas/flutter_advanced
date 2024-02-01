import 'package:flutter/material.dart';

class count_provider extends ChangeNotifier{
  int _counter =0;
  int get count => _counter;

  void  incriment(){
    _counter++;
    notifyListeners();
  }
}