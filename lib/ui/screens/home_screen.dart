import 'package:esamudaay_app/data/api_helper.dart';
import 'package:esamudaay_app/ui/widgets/webview_container.dart';
import 'package:esamudaay_app/utils/open-links.dart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/product.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.busId}) : super(key: key);
  final String busId;

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
    products = await ApiHelper.getProducts(apiUrl + widget.busId + '/report');
    setState(() {});
  }

  void search(String val) {
    String text = val.toLowerCase();
    if (text == "") {
      setState(() {});
      return;
    }
    List<Product> filteredProducts = [];
    filteredProducts = products
        .where((element) => element.productName.contains(text))
        .toList();
    print(filteredProducts.toString());
    setState(() {
      products = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     onChanged: (val) {
          //       search(val);
          //     },
          //     decoration: const InputDecoration(
          //       labelText: 'Search',
          //       // hintText: "Enter....",
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(30),
          //           ),
          //           borderSide: BorderSide()),
          //     ),
          //   ),
          // ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: (products.isNotEmpty)
              ? Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String productName = products[index].productName;
                      var failuresRes = products[index].failureReasons ?? [];
                      List<String> failures = List<String>.from(failuresRes);
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FailuresScreen(
                                failures: failures,
                              ),
                            ),
                          );
                        },
                        leading: Text(products[index].skuId.toString()),
                        title: Center(
                          child: Column(
                            children: [
                              Text(
                                productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                products[index].businessName,
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        trailing: products[index].failureReasons == null
                            ?
                            // ? IconButton(
                            //     icon: const Icon(
                            //       FontAwesomeIcons.check,
                            //       color: Colors.green,
                            //       size: 30,
                            //     ),
                            //     onPressed: () {},
                            //   )
                            // : IconButton(
                            //     icon: const Icon(
                            //       FontAwesomeIcons.close,
                            //       color: Colors.red,
                            //     ),
                            //     onPressed: () {},
                            //   ),
                            const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(
                                  FontAwesomeIcons.close,
                                  color: Colors.white,
                                ),
                              ),
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

class FailuresScreen extends StatelessWidget {
  const FailuresScreen({Key? key, required this.failures}) : super(key: key);
  final List<String> failures;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compliance Issues"),
        backgroundColor: failures.isNotEmpty ? Colors.red : Colors.green,
      ),
      body: failures.isNotEmpty
          ? Center(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text('${index + 1}.'),
                      title: Text(failures[index]),
                    ),
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: failures.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text:
                              "To know more about ONDC Compliance Policy, click ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: "here.",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewContainer(
                                        "https://docs.google.com/spreadsheets/d/1OB-TB2hn_jjQlUgKSA5x_GdpCSLIAqiDyzIkD9aMnpM/",
                                        "Compliance Criteria"),
                                  ));
                            },
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    "This product is compliant to the ONDC Standards!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            "To know more about ONDC Compliance Policy, click ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: "here.",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("clicked");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewContainer(
                                      "https://docs.google.com/spreadsheets/d/1OB-TB2hn_jjQlUgKSA5x_GdpCSLIAqiDyzIkD9aMnpM/",
                                      "Compliance Criteria"),
                                ));
                          },
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
    );
  }
}
