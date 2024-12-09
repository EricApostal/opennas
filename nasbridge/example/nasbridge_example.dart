import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/client_options.dart';
import 'package:nasbridge/src/plugin/logging.dart';

void main() async {
  print("Running example");
  final client = await Nasbridge.connectGateway(
    'root',
    'root',
    options: GatewayClientOptions(host: '192.168.80.128', plugins: [
      Logging(
        logLevel: Level.OFF,
      )
    ]),
  );

  client.system.getInfo().then((sysInfo) {
    print(sysInfo);
  });
  client.system.downloadDebug();
  print((await client.system.getAdvancedConfig()).motd);
  print(await client.system.getBootId());
  print(await client.system.getBuildTime());
  print(await client.system.getGeneralConfig());
  print(await client.system.getHostId());
  print(await client.system.getProductType());
  print(await client.system.getReleaseNotesUrl());
  print(await client.system.getState());
  print(await client.system.getVersion());
  // client.system.getVersionShort();

  await Future.delayed(Duration(seconds: 10));
}
