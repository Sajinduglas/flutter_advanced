import '../model/producr_model.dart';
import 'package:http/http.dart' as http;

class Httpservice {
  static Future<List<Products>> fetch_products() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));

    /// apiil ninnu data verunathu konde future   productverunathu enni model class vazhi annu enni data acces cheyan ,so list name modelclass name koduthu
    ///
    if (response.statusCode == 200) {
      ///statuscode 200 is success code
      var data = response.body;
      return productsFromJson(data);

      ///api il ninnu vannai data model class inte function productsfromjsonil pass cheyum
    } else {
      throw Exception();
    }
  }
}
