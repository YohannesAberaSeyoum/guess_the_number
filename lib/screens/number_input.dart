import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/change_screen.dart';
import 'package:guess_the_number/helpers/role.dart';
import 'package:guess_the_number/screens/game.dart';
import 'package:guess_the_number/widgets/custom_btn.dart';
import 'package:guess_the_number/widgets/custom_input.dart';

class NumberInputScreen extends StatelessWidget {
  final Role role;
  NumberInputScreen({@required this.role});
  @override
  Widget build(BuildContext context) {
    String value;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    void saved(String newValue) {
      value = newValue;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: CustomInput(
                    digit: this.role.digit,
                    function: saved,
                  )),
              CustomBtn(
                text: "Submit",
                function: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    if (role.role == "Client") {
                      role.makeNumber(value);
                      await role.receiveMessage();
                      role.sendMessage("a");
                    } else {
                      role.makeNumber(value);
                      role.sendMessage("a");
                      await role.receiveMessage();
                    }
                    return changeScreenReplacement(
                        context,
                        GameScreen(
                          role: role,
                          number: role.value,
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
