import 'package:flutter/material.dart';

class Section_between extends StatelessWidget {
final thickness;
final color;
final padding;
final widthSection;
final between_width;

  const Section_between({this.thickness =1.0,
    this.between_width =10.0,this.widthSection=25.0,
    this.color=Colors.black, this.padding=5.0});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SizedBox(
          width: widthSection,
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),SizedBox(width: between_width,),
        SizedBox(
          width: widthSection,
          child: Divider(
            thickness: thickness,
            color: color,
          ),

        ),SizedBox(width: between_width,),
        SizedBox(
          width: widthSection,
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),SizedBox(width: between_width,),
        SizedBox(
          width: widthSection,
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),SizedBox(width: between_width,),
        SizedBox(
          width: widthSection,
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),SizedBox(width: between_width,),
        SizedBox(
          width: widthSection,
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),

      ],mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
