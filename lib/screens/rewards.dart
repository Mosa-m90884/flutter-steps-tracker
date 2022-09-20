import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro2/utils/app_constants.dart';
import 'package:pro2/widgets/custom_text.dart';
import 'package:pro2/widgets/section_between.dart';

import '../widgets/reward_item.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
      Expanded(flex: 1, child:Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: CustomText(text: 'Rewards List'.tr,fontSize: 20,alignment: Alignment.center,),
      )
      ),
    Expanded(flex: 4, child:
        ListView.separated(shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: App_constants.rewards.length,
            itemBuilder: (context, index) {
              return RewadCard(product:App_constants.rewards[index]);
            }, separatorBuilder: (BuildContext context, int index) { return Section_between(); },
            )),
        Expanded(flex: 1, child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Get more health points and we will give you the best gifts and rewards'.tr),
        ))
      ],
    ),);
  }
}
