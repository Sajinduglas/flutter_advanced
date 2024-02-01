import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../model/data_model.dart';
import '../services/dio_service.dart';

class DataController extends GetxController {
  RxList<DataModel> datas = RxList();
  RxBool isloading = true.obs;
  RxBool isListdown = false.obs;
  RxBool isNetConnected = true.obs;

  var url = "https://jsonplaceholder.typicode.com/posts";
  var scrollController = ItemScrollController();

  void isInternatConnected() async {
    isNetConnected.value = await InternetConnectionChecker().hasConnection;
  }

  fetchData() async {
    isNetConnected();
    isloading.value = true;
    var response = await DioService().getData(url);
    if (response.statusCode == 200) {
      response.data.forEach((data) {
        datas.add(DataModel.fromJson(data));
      });
      isloading.value = false;
    }
  }

  ScroolToUP() {
    scrollController.scrollTo(
        index: 0,
        duration: Duration(seconds: 4),
        curve: Curves.linearToEaseOut);
  }
}
