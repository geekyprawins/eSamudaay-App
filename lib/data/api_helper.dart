import 'package:dio/dio.dart';
import 'package:esamudaay_app/data/models/product.dart';

class ApiHelper {
  static Future<List<Product>> getProducts(String apiUrl) async {
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
