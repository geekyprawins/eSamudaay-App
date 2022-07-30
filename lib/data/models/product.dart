import 'dart:convert';

class Product {
  Product({
    required this.skuId,
    required this.productName,
    required this.businessName,
    required this.failureReasons,
  });

  final int skuId;
  final String productName;
  final String businessName;
  final dynamic failureReasons;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        skuId: json["sku_id"],
        productName: json["product_name"],
        businessName: json["business_name"],
        failureReasons: json["failure_reasons"],
      );

  Map<String, dynamic> toMap() => {
        "sku_id": skuId,
        "product_name": productName,
        "business_name": businessName,
        "failure_reasons": failureReasons,
      };
}
