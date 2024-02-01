import 'package:get/get.dart';

class countcontroller extends GetxController{
  var count = 0.obs;
  // RxInt count1=RxInt(0);


  void incriment(){
    count++;
  }

  void decriment(){
    count--;
  }

}