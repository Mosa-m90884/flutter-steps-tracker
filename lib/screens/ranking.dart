import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro2/widgets/custom_text.dart';

import '../controller/firebase_controller.dart';
import '../controller/step_point_controller.dart';
import '../widgets/section_between.dart';
class RankScreen extends StatelessWidget {
  final firebaseController = Get.put(FirebaseController());
  //final stepPointController = Get.put(StepPointController());

   RankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    firebaseController.getallusers();
    //stepPointController.stepsUpdade();
    return SafeArea(child:
      Scaffold(body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
        Row(mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            CustomText(text: 'All Users'.tr,fontSize: 20,alignment: Alignment.center,),
          ],
        ),Section_between(),
        Obx(() {
            return firebaseController.usersList.length!=0?Container(height: MediaQuery.of(context).size.height/2,child:
              ListView.separated(itemBuilder: (context,index){
                return Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                  children: [
                    CustomText(text: firebaseController.usersList[index]['name'],),CustomText(text:' have step '.tr+ firebaseController.usersList[index]['step'],),
                  ],
                );
              },
                  separatorBuilder: (context,index){
                    return Section_between();
                  },
                  itemCount: firebaseController.usersList.length),):
            CircularProgressIndicator();
          }
        )
    ]),
      ),));
  }
}
