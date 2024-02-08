import 'package:get/get.dart';

import '../service/http_service.dart';

class ProductController extends GetxController {
  RxBool isLoading = true.obs; //here isLoading now in observable state
  var productList = [].obs;

  @override
  void onInit() {
    loadProduct(); //to fetch data from service class
    super.onInit();
  }

  void loadProduct() async {
    try {
      isLoading(true);
      var products = await Httpservice.fetch_products();
      ///fetch products inte return model class data annu model class il json decode cheythu vechakuvaa
      if (products != null) {
        productList.value = products;
      }

      ///  list il value add akan list.add annu ethu oservable ayathu konde annu list.ovalue use cheythai
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
    ///data vanalum illankilum  isloading false akanm
  }
}
