import 'package:dio/dio.dart';
import 'package:esamudaay_app/data/models/product.dart';
import 'package:esamudaay_app/utils/constants.dart';

class ApiHelper {
  static Future<List<Product>> getProducts() async {
    var response = await Dio().get(apiUrl);
    print("Products received: " + response.data.length.toString());
    List<Product> products = [];
    for (var prodJson in response.data) {
      Product product = Product.fromMap(prodJson);
      products.add(product);
    }
    return products;
  }
}
