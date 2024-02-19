import '../model/producr_model.dart';
import 'package:http/http.dart' as http;

class Httpservice {
  static Future<List<Products>> fetch_products() async {
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      ///statuscode 200 is success code

      var data = response.body;
      return productsFromJson(data);
    } else {
      throw Exception();
    }
  }
}
