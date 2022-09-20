import 'package:flutter/material.dart';
import 'package:get/get.dart';
class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body:    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text.rich(
      TextSpan(
      text:" Instructions for use:"
          " 1. This application depends on the Firebase and FireStore service, which are banned in some countries such as Syria.. To run the application, you must be connected to a VPN"
          " 2. The application depends on the tolerance of motor activity, which means when you press the start button on the main menu, you must move the device to get the largest number of steps".tr,
      style: TextStyle(
      fontWeight: FontWeight.w600, color: Colors.indigo),

      ),
      ),
    ));
  }
}
