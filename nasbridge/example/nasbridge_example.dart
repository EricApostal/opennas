import 'dart:async';

import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/client_options.dart';
import 'package:nasbridge/src/models/websocket/events/event.dart';

void main() async {
  final client = await Nasbridge.connectGateway(
    'root',
    'root',
    options: GatewayClientOptions(host: '192.168.80.128'),
  );

  bool isAuthenticating = false;
  String? sessionId;

  client.onEvent.listen((event) async {
    if (event is RawEvent) {
      print('Received raw event: ${event.data}');
    }

    if (event is ConnectedEvent) {
      if (sessionId == event.sessionId) return;
      sessionId = event.sessionId;

      print('Connected with session: $sessionId');
    } else if (event is ResultEvent && event.result == true) {
      try {
        final sysInfo = await client.sendMethod('system.info');
        print('\nSystem Information:');
        print(sysInfo);
      } catch (e) {
        print('Error getting system info: $e');
      } finally {
        await client.close();
      }
    }
  });

  await Future.delayed(Duration(seconds: 10));
}
