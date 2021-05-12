import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/change_screen.dart';
import 'package:guess_the_number/helpers/checker.dart';
import 'package:guess_the_number/helpers/custom_color.dart';
import 'package:guess_the_number/helpers/model.dart';
import 'package:guess_the_number/helpers/role.dart';
import 'package:guess_the_number/screens/digit.dart';
import 'package:guess_the_number/widgets/custom_btn.dart';
import 'package:guess_the_number/widgets/custom_input.dart';
import 'package:guess_the_number/widgets/custom_lst.dart';
import 'package:guess_the_number/widgets/custom_txt.dart';

class GameScreen extends StatefulWidget {
  final String number;
  final Role role;
  GameScreen({this.number, this.role});
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ScrollController _sc = ScrollController();
  List<Model> list = [];
  String value;
  bool tryAgain = false;

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: forthColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _sc,
              itemCount: list.length + 1,
              itemBuilder: (context, index) {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => {_sc.jumpTo(_sc.position.maxScrollExtent)});
                return CustomLst(
                  no: index == 0 ? "No" : index.toString(),
                  number: index == 0 ? "Number" : list[index - 1].number,
                  order: index == 0 ? "Order" : list[index - 1].order,
                  place: index == 0 ? "Place" : list[index - 1].place,
                  color: index == 0 ? null : tertiaryColor,
                  background: index == 0 ? primaryColor : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: tryAgain
                ? CustomBtn(
                    text: "Try Again",
                    function: () => changeScreenReplacement(
                      context,
                      DigitScreen(),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: _key,
                        child: CustomInput(
                          digit: widget.number.length,
                          function: saved,
                        ),
                      ),
                      CustomBtn(
                        text: "Submit",
                        function: () async {
                          if (_key.currentState.validate()) {
                            _key.currentState.save();
                            int place;
                            int order;
                            if (widget.role == null) {
                              place = placeCount(
                                  input: value, number: widget.number);
                              order = orderCount(
                                  input: value, number: widget.number);
                            } else {
                              if (widget.role.role == "Client") {
                                await widget.role.receiveMessage();
                                widget.role.sendMessage(
                                    "value${widget.role.oppo.place} ${widget.role.oppo.order} $value");
                                await widget.role.receiveMessage();
                              } else {
                                widget.role.sendMessage("before$value");
                                await widget.role.receiveMessage();
                                widget.role.sendMessage(
                                    "value${widget.role.oppo.place} ${widget.role.oppo.order}");
                              }
                              order = int.parse(widget.role.self.order);
                            }
                            if (order == widget.number.length) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: CustomTxt(
                                    text: "Congratulation",
                                    color: primaryColor,
                                  ),
                                  content: CustomTxt(
                                    text: "Do you want to try again?",
                                    color: secondaryColor,
                                  ),
                                  actions: [
                                    CustomBtn(
                                      text: "Yes",
                                      function: () => changeScreenReplacement(
                                        context,
                                        DigitScreen(),
                                      ),
                                    ),
                                    CustomBtn(
                                      text: "No",
                                      function: () {
                                        setState(
                                          () {
                                            tryAgain = true;
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                            setState(
                              () {
                                widget.role != null
                                    ? list.add(widget.role.self)
                                    : list.add(Model(
                                        number: value,
                                        place: place,
                                        order: order));
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void saved(String newValue) {
    value = newValue;
  }
}
