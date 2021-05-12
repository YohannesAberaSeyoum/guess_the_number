import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/change_screen.dart';
import 'package:guess_the_number/helpers/checker.dart';
import 'package:guess_the_number/helpers/custom_color.dart';
import 'package:guess_the_number/helpers/role.dart';
import 'package:guess_the_number/screens/game.dart';
import 'package:guess_the_number/screens/number_input.dart';
import 'package:guess_the_number/widgets/custom_btn.dart';
import 'package:guess_the_number/widgets/custom_txt.dart';

class DigitScreen extends StatefulWidget {
  final Role role;
  DigitScreen({this.role});
  @override
  _DigitScreenState createState() => _DigitScreenState();
}

class _DigitScreenState extends State<DigitScreen> {
  final items = List.generate(10,
          (index) => index == 0 ? "${index + 1} item" : "${index + 1} items")
      .map(
        (value) => DropdownMenuItem(
          value: value,
          child: CustomTxt(
            text: value,
          ),
        ),
      )
      .toList();
  String dropdownValue = "1 item";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: forthColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: items),
              CustomBtn(
                  text: "Submit",
                  function: () {
                    if (widget.role != null) {
                      widget.role.sendMessage("digit${dropdownValue.split(" ")[0]}");
                    }
                    return widget.role == null
                        ? changeScreenReplacement(
                            context,
                            GameScreen(
                              number: guessNumber(
                                int.parse(dropdownValue.split(" ")[0]),
                              ),
                            ),
                          )
                        : changeScreenReplacement(
                            context,
                            NumberInputScreen(role: widget.role),
                          );
                  }),
            ],
          )
        ],
      ),
    );
  }
}
