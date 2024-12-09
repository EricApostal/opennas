import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/gateway/managers/manager.dart';
import 'package:nasbridge/src/models/system/system_data.dart';

/// Manager class for handling SystemInfo operations through the TrueNAS API.
class SystemManager extends Manager<SystemInfo> {
  /// Creates a new instance of [SystemManager].
  ///
  /// The [client] parameter is required for making API requests.
  SystemManager(super.client);

  /// Fetches the current system information.
  ///
  /// Returns a [Future] that completes with a [SystemInfo] instance.
  Future<SystemInfo> getInfo() async {
    final gatewayClient = client as NasbridgeGateway;
    print("sending method");
    final response = await gatewayClient.sendMethod('system.info');
    print("got response!");
    return parseSystemInfo(response as Map<String, Object?>);
  }

  SystemInfo parseSystemInfo(Map<String, Object?> raw) {
    return SystemInfo(
      version: raw['version'] as String,
      buildtime: (raw['buildtime'] as Map<String, dynamic>)[r"$date"] as int,
      hostname: raw['hostname'] as String,
      physmem: raw['physmem'] as int,
      model: raw['model'] as String,
      cores: raw['cores'] as int,
      physicalCores: raw['physical_cores'] as int?,
      loadavg: raw['loadavg'] as List<dynamic>,
      uptime: raw['uptime'] as String,
      uptimeSeconds: raw['uptime_seconds'] as double,
      systemSerial: raw['system_serial'] as String?,
      systemProduct: raw['system_product'] as String?,
      systemProductVersion: raw['system_product_version'] as String?,
      license: (raw['license'] as Map<String, dynamic>?) ?? {},
      boottime: (raw['boottime'] as Map<String, dynamic>)[r"$date"] as int,
      datetime: (raw['datetime'] as Map<String, dynamic>)[r"$date"] as int,
      timezone: raw['timezone'] as String,
      systemManufacturer: raw['system_manufacturer'] as String?,
      eccMemory: raw['ecc_memory'] as bool,
    );
  }
}
