import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/change_screen.dart';
import 'package:guess_the_number/helpers/custom_color.dart';
import 'package:guess_the_number/screens/digit.dart';
import 'package:guess_the_number/screens/role.dart';
import 'package:guess_the_number/widgets/custom_btn.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: forthColor,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBtn(
              text: "SinglePlayer",
              function: () => changeScreen(context, DigitScreen()),
            ),
            CustomBtn(
              text: "MultiPlayer",
              function: () => changeScreen(
                context,
                RoleScreen(),
              ),
            ),
            CustomBtn(
              text: "Helper",
            ),
          ],
        ),
      ),
    );
  }
}
