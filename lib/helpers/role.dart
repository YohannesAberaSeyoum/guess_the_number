import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:guess_the_number/helpers/checker.dart';
import 'package:guess_the_number/helpers/model.dart';
import 'package:wifi/wifi.dart';

class Role {
  Socket socket;
  var listen;
  String value;
  int digit;
  bool receiving;
  Model oppo;
  Model self;
  String guessed;
  String role;
  List<WifiResult> hosts;

  Role() {
    this.receiving = false;
  }

  Future<void> makeClient() async {
    this.role = "Client";
    this.socket = await Socket.connect("192.168.43.1", 4567);
    print(
        'Connected to: ${this.socket.remoteAddress.address}:${this.socket.remotePort}');
    this.makeListening();
  }

  void getHosts() async {
    Wifi.list("").then((value) {
      hosts = value;
      print(hosts);
    });
  }

  Future<void> makeServer() async {
    this.role = "Server";
    // bind the socket server to an address and port
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
    // listen for clent connections to the server
    server.listen((client) {
      this.socket = client;
      print('Connection from'
          ' ${client.remoteAddress.address}:${client.remotePort}');
      this.makeListening();
      this.receiving = false;
    });
    this.receiving = true;
    while (this.receiving) {
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void makeListening() {
    this.listen = this.socket.listen(
      // handle data from the server
      (Uint8List data) {
        print("getting data");
        final serverResponse = String.fromCharCodes(data);
        this.serveData(serverResponse);
      },

      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    this.listen.pause();
  }

  void serveData(String msg) {
    List<String> list;
    if (msg[0] == "d") {
      print("You received digit");
      list = msg.split("digit");
      this.digit = int.parse(list[list.length - 1]);
      print(this.digit);
    } else if (msg[0] == "v") {
      list = msg.split("value");
      list = list[list.length - 1].split(" ");
      this.self = Model(
        number: this.guessed,
        place: int.parse(list[0]),
        order: int.parse(list[1]),
      );
      if (list.length == 3) {
        int place =
            placeCount(input: list[list.length - 1], number: this.value);
        int order =
            orderCount(input: list[list.length - 1], number: this.value);
        this.oppo = Model(number: list[2], place: place, order: order);
      }
    } else if (msg[0] == "b") {
      list = msg.split("before");
      int place = placeCount(input: list[list.length - 1], number: this.value);
      int order = orderCount(input: list[list.length - 1], number: this.value);
      this.oppo =
          Model(number: list[list.length - 1], place: place, order: order);
    }
    this.receiving = false;
  }

  void makeNumber(number) {
    this.value = number;
  }

  void sendMessage(message) {
    List<String> list;
    if (message[0] == "d") {
      this.digit = int.parse(message.substring(5));
    } else if (message[0] == "v") {
      list = message.split("value");
      list = list[list.length - 1].split(" ");
      if (list.length == 3) {
        this.guessed = list[2];
      }
    }
    print('Client: $message');
    this.socket.write(message);
  }

  Future<void> receiveMessage() async {
    this.receiving = true;
    this.listen.resume();
    print("receiving");
    while (this.receiving) {
      await Future.delayed(Duration(seconds: 1));
    }
    print("received");
    this.listen.pause();
  }
}
