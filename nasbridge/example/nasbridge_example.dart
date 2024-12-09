import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/client_options.dart';
import 'package:nasbridge/src/models/gateway/events/event.dart';
import 'package:nasbridge/src/plugin/logging.dart';

void main() async {
  print("initializing nasbridge");
  final client = await Nasbridge.connectGateway(
    'root',
    'Marlowmax12!',
    options: GatewayClientOptions(host: '192.168.80.128', plugins: [
      Logging(
        logLevel: Level.OFF,
      )
    ]),
  );

  // print("GETTING INFO!");
  client.system.getInfo().then((sysInfo) {
    print(sysInfo);
  });

  // client.onConnected.listen((event) async {
  //   print("connected!");
  //   // print('Received event: $event');
  //   // print("getting system info async");
  //   // client.system.getInfo().then((sysInfo) {
  //   //   print(sysInfo);
  //   // });
  // });

  // client.onEvent.listen((event) async {
  //   print('Received event: $event');
  //   if (event is ResultEvent) {
  //     print("result event");
  //     print(event.result);
  //   }
  // });

  await Future.delayed(Duration(seconds: 10));
}
