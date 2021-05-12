import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/custom_color.dart';
import 'package:guess_the_number/widgets/custom_txt.dart';

class CustomLst extends StatelessWidget {
  final String no;
  final String number;
  final String place;
  final String order;
  final Color color;
  final Color background;
  CustomLst({this.no, this.number, this.order, this.place, this.color, this.background});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          color: background ?? secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTxt(
                text: no,
                color: color,
              ),
              CustomTxt(
                text: number,
                color: color,
              ),
              CustomTxt(
                text: place,
                color: color,
              ),
              CustomTxt(
                text: order,
                color: color,
              ),
            ],
          ),
        ));
  }
}
