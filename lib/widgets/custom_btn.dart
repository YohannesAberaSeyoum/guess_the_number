import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/custom_color.dart';
import 'package:guess_the_number/widgets/custom_txt.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function function;
  CustomBtn({this.text, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: tertiaryColor,
          child: CustomTxt(
            text: text,
          ),
        ),
      )
    );
  }
}
