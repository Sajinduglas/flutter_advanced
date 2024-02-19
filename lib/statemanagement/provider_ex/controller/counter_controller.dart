import 'package:flutter/material.dart';

import '../model/count.dart';
class CounterProvider extends ChangeNotifier{

  Count incCounter=Count(0);///model class connection ondu
  Count get counter_value=>incCounter;
  void increment_Count(){
    incCounter.value++;
    notifyListeners();
    }

}