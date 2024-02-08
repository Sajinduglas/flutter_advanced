import 'package:flutter/material.dart';
import 'package:flutter_advanced/Api_integration/api_integration%20using_http/view/widgets/product_tile.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';

void main(){
  runApp(GetMaterialApp(home: ApiHome(),));
}
class ApiHome extends StatelessWidget {
  final productController = Get.put(ProductController());
///controller intialised by get.put
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api_http&getx"),
      ),
      body: SizedBox(
        child: Obx(() {//body data full observable annu so obx vechu wrap cheythu
          if (productController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return GridView.builder(
                itemCount: productController.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4), itemBuilder: (context, index) {
              return ProductTile(productController.productList[index]);
            });
          }
        }),
      ),
    );
  }
}