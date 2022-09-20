import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro2/widgets/primary_button.dart';

import '../controller/step_point_controller.dart';
import '../utils/app_constants.dart';
import '../utils/color_resources.dart';
import '../widgets/custom_text.dart';
import '../widgets/section_between.dart';
import 'footsteps.dart';
class HomeScreen extends StatelessWidget {
  final footstepsController = Get.put(StepPointController());
  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'عربي','locale': Locale('ar','AR')},
  ];
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [
     CustomText(text: 'language'.tr,alignment: Alignment.center,color:ColorResources.WHITE),
      IconButton( onPressed: (){
        buildLanguageDialog(context);

      }, icon: Icon(Icons.language),)]),
      body: SafeArea(child: Obx(() {
          return ListView(children: [
            SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(text: 'health Point :'.tr,alignment: Alignment.center),
              CustomText(text: '${footstepsController.health_point.value}',),

            ],
          ),
            Section_between(),
            SizedBox(height: 25),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(text: 'foot steps:'.tr,alignment: Alignment.center),
                CustomText(text: '${footstepsController.step_points.value}',),

              ],
            ),
            Section_between(),
          Container(color: Colors.lime,height: 300,child: FootSteps(title: 'steps_counter',))
            ,Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(label: 'replace to health point'.tr,onPress: (){
                footstepsController.replaceToHealthPoint(footstepsController.step_points.value);},),
            )
    ],);
        }
      )),);
  }
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }
}
