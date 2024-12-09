import 'package:nasbridge/src/builders/system/advanced_config.dart';
import 'package:nasbridge/src/builders/system/general_config.dart';
import 'package:nasbridge/src/builders/system/npt_server.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/gateway/managers/manager.dart';
import 'package:nasbridge/src/models/system/advanced_config.dart';
import 'package:nasbridge/src/models/system/data.dart';
import 'package:nasbridge/src/models/system/general_config.dart';
import 'package:nasbridge/src/models/system/nptserver.dart';

/// Manager class for handling System operations through the TrueNAS API.
class SystemManager extends Manager<SystemInfo> {
  /// Creates a new instance of [SystemManager].
  SystemManager(super.client);

  /// Fetches the current system information.
  Future<SystemInfo> getInfo() async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient.sendMethod('system.info');
    return parseSystemInfo(response as Map<String, Object?>);
  }

  /// Gets the boot identifier
  Future<String> getBootId() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.boot_id') as String;
  }

  /// Gets the system build time
  Future<int> getBuildTime() async {
    final gatewayClient = client as NasbridgeGateway;
    return (await gatewayClient.sendMethod('system.build_time')
        as Map<String, dynamic>)[r"$date"] as int;
  }

  /// Downloads a debug file
  Future<void> downloadDebug() async {
    final gatewayClient = client as NasbridgeGateway;
    await gatewayClient.sendMethod('system.debug');
  }

  /// Checks if a specific feature is enabled
  Future<bool> isFeatureEnabled(String feature) async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.feature_enabled', [feature])
        as bool;
  }

  /// Gets the host identifier
  Future<String> getHostId() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.host_id') as String;
  }

  /// Checks if the system version is stable
  Future<String> isStable() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.is_stable') as String;
  }

  /// Updates the system license
  Future<void> updateLicense(String license) async {
    final gatewayClient = client as NasbridgeGateway;
    await gatewayClient.sendMethod('system.license_update', [license]);
  }

  /// Gets the product type
  Future<String> getProductType() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.product_type') as String;
  }

  /// Checks if the system is ready
  Future<bool> isReady() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.ready') as bool;
  }

  /// Reboots the system
  Future<void> reboot({int? delay}) async {
    final gatewayClient = client as NasbridgeGateway;
    await gatewayClient.sendMethod('system.reboot', [
      {'delay': delay}
    ]);
  }

  /// Gets the release notes URL
  Future<String?> getReleaseNotesUrl([String? version]) async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod(
            'system.release_notes_url', version != null ? [version] : [])
        as String?;
  }

  /// Shuts down the system
  Future<void> shutdown({int? delay}) async {
    final gatewayClient = client as NasbridgeGateway;
    await gatewayClient.sendMethod('system.shutdown', [
      {'delay': delay}
    ]);
  }

  /// Gets the system state
  Future<String> getState() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.state') as String;
  }

  /// Gets the full version
  Future<String> getVersion() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.version') as String;
  }

  // /// Gets the short version
  // Future<String> getVersionShort() async {
  //   final gatewayClient = client as NasbridgeGateway;
  //   // returns null?
  //   return await gatewayClient.sendMethod('system.version_short') as String;
  // }

  /// Gets the advanced system configuration
  Future<SystemAdvancedConfig> getAdvancedConfig() async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient.sendMethod('system.advanced.config');
    return parseSystemAdvancedConfig(response as Map<String, Object?>);
  }

  /// Updates the advanced system configuration
  Future<SystemAdvancedConfig> updateAdvancedConfig(
      SystemAdvancedConfigUpdateBuilder builder) async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient
        .sendMethod('system.advanced.update', [builder.build()]);
    return parseSystemAdvancedConfig(response as Map<String, Object?>);
  }

  /// Gets the general system configuration
  Future<SystemGeneralConfig> getGeneralConfig() async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient.sendMethod('system.general.config');
    return parseSystemGeneralConfig(response as Map<String, Object?>);
  }

  /// Updates the general system configuration
  Future<SystemGeneralConfig> updateGeneralConfig(
      SystemGeneralConfigUpdateBuilder builder) async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient
        .sendMethod('system.general.update', [builder.build()]);
    return parseSystemGeneralConfig(response as Map<String, Object?>);
  }

  /// Creates a new NTP server
  Future<NtpServer> createNtpServer(NtpServerBuilder builder) async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient
        .sendMethod('system.ntpserver.create', [builder.build()]);
    return parseNtpServer(response as Map<String, Object?>);
  }

  /// Updates an existing NTP server
  Future<NtpServer> updateNtpServer(
      int id, NtpServerUpdateBuilder builder) async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient
        .sendMethod('system.ntpserver.update', [id, builder.build()]);
    return parseNtpServer(response as Map<String, Object?>);
  }

  /// Deletes an NTP server
  Future<bool> deleteNtpServer(int id) async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('system.ntpserver.delete', [id])
        as bool;
  }

  /// Parses system info response into a SystemInfo object
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

  /// Parses advanced config response
  SystemAdvancedConfig parseSystemAdvancedConfig(Map<String, Object?> raw) {
    return SystemAdvancedConfig(
      advancedmode: raw['advancedmode'] as bool,
      autotune: raw['autotune'] as bool,
      kdumpEnabled: raw['kdump_enabled'] as bool?,
      bootScrub: raw['boot_scrub'] as int,
      consolemenu: raw['consolemenu'] as bool,
      consolemsg: raw['consolemsg'] as bool,
      debugkernel: raw['debugkernel'] as bool,
      fqdnSyslog: raw['fqdn_syslog'] as bool,
      motd: raw['motd'] as String,
      loginBanner: raw['login_banner'] as String?,
      powerdaemon: raw['powerdaemon'] as bool,
      serialconsole: raw['serialconsole'] as bool,
      serialport: raw['serialport'] as String,
      serialspeed: raw['serialspeed'] as String,
      syslogserver: raw['syslogserver'] as String?,
      syslogTransport: raw['syslog_transport'] as String,
      sysloglevel: raw['sysloglevel'] as String,
      traceback: raw['traceback'] as bool,
      uploadcrash: raw['uploadcrash'] as bool,
      id: raw['id'] as int,
    );
  }

  /// Parses general config response
  SystemGeneralConfig parseSystemGeneralConfig(Map<String, Object?> raw) {
    return SystemGeneralConfig(
      id: raw['id'] as int,
      uiCertificate: raw['ui_certificate'] as Map<String, dynamic>,
      uiHttpsport: raw['ui_httpsport'] as int,
      uiHttpsredirect: raw['ui_httpsredirect'] as bool,
      uiHttpsprotocols:
          (raw['ui_httpsprotocols'] as List<dynamic>).cast<String>(),
      uiPort: raw['ui_port'] as int,
      uiAddress: (raw['ui_address'] as List<dynamic>).cast<String>(),
      uiV6address: (raw['ui_v6address'] as List<dynamic>).cast<String>(),
      uiAllowlist: (raw['ui_allowlist'] as List<dynamic>?)?.cast<String>(),
      uiConsolemsg: raw['ui_consolemsg'] as bool?,
      uiXFrameOptions: raw['ui_x_frame_options'] as String?,
      kbdmap: raw['kbdmap'] as String,
      language: raw['language'] as String,
      timezone: raw['timezone'] as String,
      usageCollection: raw['usage_collection'] as bool?,
      wizardshown: raw['wizardshown'] as bool,
      dsAuth: raw['ds_auth'] as bool?,
    );
  }

  /// Parses NTP server response
  NtpServer parseNtpServer(Map<String, Object?> raw) {
    return NtpServer(
      id: raw['id'] as int,
      address: raw['address'] as String,
      burst: raw['burst'] as bool,
      iburst: raw['iburst'] as bool,
      prefer: raw['prefer'] as bool,
      minpoll: raw['minpoll'] as int,
      maxpoll: raw['maxpoll'] as int,
    );
  }
}
