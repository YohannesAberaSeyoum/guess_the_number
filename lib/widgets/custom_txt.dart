import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/custom_color.dart';

class CustomTxt extends StatelessWidget {
  final Color color;
  final String text;
  CustomTxt({this.text, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? fifthColor,
          fontSize: 18,
        ),
      ),
    );
  }
}
