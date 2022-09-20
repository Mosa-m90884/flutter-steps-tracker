import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

class CustomBottomSheet extends StatelessWidget {
  final IconData image;
  final String title;
  final Widget widget;
  CustomBottomSheet({ required this.image, required this.title, required this.widget,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
      },

      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 0.3)],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(image, size: MediaQuery.of(context).size.width/12, color: ColorResources.GREY,),
             /* SvgPicture.asset(
                  image, height: 30,width: 30,
                  color: ColorResources.getHint(context)),*/
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                ),
              ),
            ]),
      ),
    );
  }
}
