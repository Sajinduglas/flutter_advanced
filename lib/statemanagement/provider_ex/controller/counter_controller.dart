import 'package:flutter/material.dart';

import '../model/count.dart';
class CounterProvider extends ChangeNotifier{

  Count incCounter=Count(0);
  Count get counter_value=>incCounter;
  void increment_Count(){
    incCounter.value++;
    notifyListeners();
    }

}