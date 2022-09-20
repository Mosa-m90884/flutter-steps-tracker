import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/welcom_controller.dart';

class WelcomeScreen extends StatelessWidget {
  final welcomeController = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: welcomeController.screens[welcomeController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: welcomeController.currentIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'Rewards'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Ranking'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subtitles_rounded),
              label: 'history'.tr,
            ),
          ],
          onTap: (index) {
            welcomeController.currentIndex.value = index;
          },
        ),
      );
    });
  }
}
