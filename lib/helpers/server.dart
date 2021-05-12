import 'dart:io';
import 'dart:typed_data';
import 'package:guess_the_number/helpers/checker.dart';

void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);

  // listen for clent connections to the server
  server.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client) {
  print('Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}');

  // listen for events from the client
  // client.write('number 4096');
  print("Write");
  client.write("digit6");
  client.write("digit3");
  client.write("digit9");
  client.listen(
    // handle data from the client
    (Uint8List data) async {
      final message = String.fromCharCodes(data);
      final List<String> result = message.split(" ");
      print(message);
      final int place = placeCount(input: result[0], number: "3097");
      final int order = orderCount(input: result[0], number: "3097");
      client.write("$place $order");
    },

    // handle errors
    onError: (error) {
      print(error);
      client.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Client left');
      client.close();
    },
  );
}
