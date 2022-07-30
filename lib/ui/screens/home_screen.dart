import 'package:esamudaay_app/data/api_helper.dart';
import 'package:flutter/material.dart';

import '../../data/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  getProducts() async {
    products = await ApiHelper.getProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: (products.isNotEmpty)
              ? Center(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      String productName = products[index].productName;
                      return GestureDetector(
                        child: Container(
                          color: Colors.teal.withOpacity(0.8),
                          width: 150,
                          height: 75,
                          child: Center(
                            child: Text(productName),
                          ),
                        ),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: products.length,
                  ),
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
