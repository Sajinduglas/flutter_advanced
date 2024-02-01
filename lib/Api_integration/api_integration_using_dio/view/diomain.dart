import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_home_dio.dart';
void main(){
  runApp(DioMain());
}
class DioMain extends StatelessWidget {
  const DioMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: DataHomeDio(),
    );
  }
}
