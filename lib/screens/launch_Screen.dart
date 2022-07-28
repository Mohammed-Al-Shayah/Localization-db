// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:myproject/shared_pref/shared_pref_controller.dart';

class Launch_Screen extends StatefulWidget {
  const Launch_Screen({Key? key}) : super(key: key);

  @override
  State<Launch_Screen> createState() => _Launch_ScreenState();
}

class _Launch_ScreenState extends State<Launch_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds:3 ),() {
      String route=SharedPrefController().loggedIn?"/Home_Screen":"/login_Screen";
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, colors: [
            Colors.pinkAccent.shade200,
            Colors.cyan.shade100,
          ]),
        ),
        child: const Center(
            child: Text(
          'Flutter App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
