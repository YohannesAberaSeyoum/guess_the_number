import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/checker.dart';

class CustomInput extends StatelessWidget {
  final int digit;
  final Function function;
  CustomInput({this.function, this.digit});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      child: TextFormField(
        validator: (String value) => validator(input: value, digit: digit),
        onSaved: function,
        decoration: InputDecoration(
          hintText: "Guess the Number here",
        ),
      ),
    );
  }
}
