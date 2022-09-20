import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/firebase_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/section_between.dart';
class HistoryScreen extends StatelessWidget {
  final firebaseController = Get.put(FirebaseController());

   HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    firebaseController.getExchangesData();
    firebaseController.getRedemptionData();

    return SafeArea(child:
    Scaffold(body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            CustomText(text: 'All Exchanges'.tr,fontSize: 20,alignment: Alignment.center,),
          ],
        ),
        Section_between(),
        Obx(() {
          return firebaseController.exchangesList.length!=0?Container(height: MediaQuery.of(context).size.height/3,child:
          ListView.separated(itemBuilder: (context,index){
            return Row(mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                CustomText(text:'you got '.tr+firebaseController.exchangesList[index]['helthPoint'],fontSize: 12),
                CustomText(text:' h.Points in date '.tr+ firebaseController.exchangesList[index]['e_date'],fontSize: 12),
              ],
            );
          },
              separatorBuilder: (context,index){
                return Section_between();
              },
              itemCount: firebaseController.exchangesList.length),):
          CircularProgressIndicator();
        }
        ), SizedBox(height: 15),       Row(mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: 'All redemption'.tr,fontSize: 20,alignment: Alignment.center,),
            ),
          ],
        ),
        Section_between(),
        Obx(() {
          return firebaseController.redemptionList.length!=0?Container(height: MediaQuery.of(context).size.height/3,child:
          ListView.separated(itemBuilder: (context,index){
            return Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: [
                CustomText(text:'-'+ firebaseController.redemptionList[index]['healthPoint'],),CustomText(text:' spent it on '.tr+ firebaseController.redemptionList[index]['reward'],),
              ],
            );
          },
              separatorBuilder: (context,index){
                return Section_between();
              },
              itemCount: firebaseController.redemptionList.length),):
          CircularProgressIndicator();
        }
        )
      ]),
    ),));
  }
}
