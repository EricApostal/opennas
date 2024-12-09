import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nasbridge/src/builders/active_directory/active_directory.dart';
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

  /// SYSTEM
  // print((await client.system.getAdvancedConfig()).motd);
  // print(await client.system.getBootId());
  // print(await client.system.getBuildTime());
  // print(await client.system.getGeneralConfig());
  // print(await client.system.getHostId());
  // print(await client.system.getProductType());
  // print(await client.system.getReleaseNotesUrl());
  // print(await client.system.getState());
  // print(await client.system.getVersion());

  /// ACTIVE DIRECTORY
  // print(await client.activeDirectory.getConfig());
  // print(await client.activeDirectory.getDomainInfo());
  // print(await client.activeDirectory.getSpnList());
  // print(await client.activeDirectory.getState());
  // print(await client.activeDirectory.getNssInfoChoices());
  // print(await client.activeDirectory.isStarted());
  // _testActiveDirectory(client);

  await Future.delayed(Duration(seconds: 10));
}

void _testActiveDirectory(NasbridgeGateway client) async {
  // Test config
  print('Testing config...');
  try {
    final config = await client.activeDirectory.getConfig();
    print('Config: ${config.domainName}');
  } catch (e) {
    print('Config error: $e');
  }

  // Test changeTrustAccountPassword
  print('\nTesting change trust account password...');
  try {
    await client.activeDirectory.changeTrustAccountPassword();
    print('Trust account password changed successfully');
  } catch (e) {
    print('Change trust password error: $e');
  }

  // Test getDomainInfo
  print('\nTesting domain info...');
  try {
    final info = await client.activeDirectory.getDomainInfo();
    print('Domain info: ${info?.realm}');
  } catch (e) {
    print('Domain info error: $e');
  }

  // Test getSpnList
  print('\nTesting SPN list...');
  try {
    final spnList = await client.activeDirectory.getSpnList();
    print('SPN List: $spnList');
  } catch (e) {
    print('SPN list error: $e');
  }

  // Test getState
  print('\nTesting state...');
  try {
    final state = await client.activeDirectory.getState();
    print('State: $state');
  } catch (e) {
    print('State error: $e');
  }

  // Test getNssInfoChoices
  print('\nTesting NSS info choices...');
  try {
    final choices = await client.activeDirectory.getNssInfoChoices();
    print('NSS Info Choices: $choices');
  } catch (e) {
    print('NSS info choices error: $e');
  }

  // Test isStarted
  print('\nTesting started status...');
  try {
    final started = await client.activeDirectory.isStarted();
    print('Is Started: $started');
  } catch (e) {
    print('Started status error: $e');
  }

  // Test update (be careful with this one!)
  print('\nTesting update...');
  // try {
  final builder = ActiveDirectoryUpdateBuilder()
    ..setDomainName('example.com')
    ..setEnable(true);
  final updated = await client.activeDirectory.update(builder);
  print('Updated config: ${updated?.domainName}');
  // } catch (e) {
  //   print('Update error: $e');
  //   // throw stack trace
  //   print(e);
  // }

  // Test leave (be very careful with this one!)
  print('\nTesting leave...');
  try {
    await client.activeDirectory.leave(username: 'admin', password: 'password');
    print('Left domain successfully');
  } catch (e) {
    print('Leave domain error: $e');
  }
}
