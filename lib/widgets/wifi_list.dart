import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_number/helpers/role.dart';
import 'package:guess_the_number/widgets/custom_btn.dart';
import 'package:wifi/wifi.dart';
import 'package:wifi_flutter/wifi_flutter.dart';

class WifiListWidget extends StatefulWidget {
  final Role role;
  WifiListWidget(this.role);
  @override
  _WifiListState createState() => _WifiListState();
}

class _WifiListState extends State<WifiListWidget> {
  List<WifiResult> hosts;
  @override
  void initState() {
    super.initState();
    getHosts();
  }

  @override
  Widget build(BuildContext context) {
    print("hosts");
    print(hosts);
    return hosts == null
        ? Container()
        : Expanded(
            child: ListView.builder(
            itemCount: hosts.length,
            itemBuilder: (BuildContext context, int index) => CustomBtn(
              text: hosts[index].ssid,
            ),
          ));
  }

  void getHosts() async {
    while (true) {
      await Wifi.list('').then(
        (value) {
          print(checkEquality(value));
          print(value);
          if (!checkEquality(value)) {
            setState(
              () {
                hosts = value;
                print("changed");
              },
            );
          }
        },
      );
      await Future.delayed(Duration(seconds: 1));
    }
  }

  bool checkEquality(List<WifiResult> value) {
    if (hosts == null) {
      print("null");
      return false;
    } else if (hosts.length != value.length) {
      return false;
    } else {
      for (int i = 0; i < value.length; i++) {
        print(hosts[i].ssid);
        print(value[i].level);
        if (hosts[i].ssid != value[i].ssid) {
          return false;
        }
      }
      return true;
    }
  }
}
