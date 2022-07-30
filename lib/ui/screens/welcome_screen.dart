import 'package:esamudaay_app/ui/screens/home_screen.dart';
import 'package:esamudaay_app/utils/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("eSamudaay"),
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // controller: ctrl,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                  ),
                  initialValue: dummyProdId,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            busId: dummyProdId,
                          ),
                        ));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Search',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
