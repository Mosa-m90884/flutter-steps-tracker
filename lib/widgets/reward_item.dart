import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro2/model/reward.dart';
import 'package:pro2/widgets/custom_bottom_sheet.dart';
import 'package:pro2/widgets/primary_button.dart';

import '../controller/step_point_controller.dart';

class RewadCard extends StatelessWidget {
  final footstepsController = Get.put(StepPointController());

  RewadCard({
    Key? key,
     required this.product,
  }) : super(key: key);

  final Reward product;
  //final controller=Get.put(Favoritecontroller());

  @override
  Widget build(BuildContext context) {
    //controller.setColor(product.product);
    return Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${product.name}',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900, fontSize: 25),
              maxLines: 2,
            ),
            SizedBox(height: 1),
            SizedBox(height: 4),

            SizedBox(height: 4),
          ],
        ),            Text.rich(
          TextSpan(
            text: "price:  ${product.price} heathpoint",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.indigo),

          ),
        )

        ,
        SizedBox(
          width: 100,
          child: Container(height: 100,
            padding: EdgeInsets.all((5)),
            decoration: BoxDecoration(border:Border.all(color: Colors.black12) ,
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
         child: PrimaryButton(label: 'buy',onPress: (){
           if(product.price>footstepsController.health_point.value){
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content:
                 Text('You do not have the number of health points to purchase this product'),
                   backgroundColor: Colors.red,));

           }else{
            footstepsController.replaceToReward(product);
             ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:
             Text('Purchase completed successfully'), backgroundColor: Colors.green,));
           }

         },)
          ),
        ),
      ],
    );
  }
}
