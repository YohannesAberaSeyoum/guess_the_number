// import 'package:flutter/material.dart';
// import 'package:guess_the_number/helpers/change_screen.dart';
// import 'package:guess_the_number/helpers/role.dart';
// import 'package:guess_the_number/screens/digit.dart';
// import 'package:guess_the_number/screens/number_input.dart';
// import 'package:guess_the_number/widgets/custom_btn.dart';
// import 'package:guess_the_number/widgets/wifi_list.dart';

// class RoleScreen extends StatelessWidget {
//   final Role role = Role();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CustomBtn(
//               text: "Host",
//               function: () async {
//                 await role.makeServer();
//                 print("role");
//                 print(role.digit);
//                 return changeScreen(context, DigitScreen(role: role));
//               },
//             ),
//             CustomBtn(
//               text: "Client",
//               function: () async {
//                 // await role.makeClient();
//                 // await role.receiveMessage();
//                 role.getHosts();
//                 // return changeScreen(
//                 //   context,
//                 //   NumberInputScreen(
//                 //     role: role,
//                 //   ),
//                 // );
//               },
//             ),
//             WifiListWidget(role)
//           ],
//         ),
//       ),
//     );
//   }
// }
