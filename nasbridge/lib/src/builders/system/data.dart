import 'package:nasbridge/src/builders/builder.dart';
import 'package:nasbridge/src/models/system/data.dart';

// idk why I made a builder for this, I don't see any use case for it

/// Builder for creating a new SystemInfo instance.
class SystemInfoBuilder extends CreateBuilder<SystemInfo> {
  String? _version;
  String? _buildtime;
  String? _hostname;
  int? _physmem;
  String? _model;
  int? _cores;
  int? _physicalCores;
  List<dynamic>? _loadavg;
  String? _uptime;
  double? _uptimeSeconds;
  String? _systemSerial;
  String? _systemProduct;
  String? _systemProductVersion;
  Map<String, dynamic>? _license;
  String? _boottime;
  String? _datetime;
  String? _timezone;
  String? _systemManufacturer;
  bool? _eccMemory;

  /// Sets the TrueNAS version
  void setVersion(String version) => _version = version;

  /// Sets the TrueNAS build time
  void setBuildtime(String buildtime) => _buildtime = buildtime;

  /// Sets the system hostname
  void setHostname(String hostname) => _hostname = hostname;

  /// Sets the physical memory in bytes
  void setPhysmem(int physmem) => _physmem = physmem;

  /// Sets the CPU model
  void setModel(String model) => _model = model;

  /// Sets the number of CPU cores
  void setCores(int cores) => _cores = cores;

  /// Sets the number of physical CPU cores
  void setPhysicalCores(int physicalCores) => _physicalCores = physicalCores;

  /// Sets the system load averages
  void setLoadavg(List<dynamic> loadavg) => _loadavg = loadavg;

  /// Sets the system uptime string
  void setUptime(String uptime) => _uptime = uptime;

  /// Sets the system uptime in seconds
  void setUptimeSeconds(double uptimeSeconds) => _uptimeSeconds = uptimeSeconds;

  /// Sets the system serial number
  void setSystemSerial(String? systemSerial) => _systemSerial = systemSerial;

  /// Sets the system product name
  void setSystemProduct(String? systemProduct) =>
      _systemProduct = systemProduct;

  /// Sets the system product version
  void setSystemProductVersion(String? version) =>
      _systemProductVersion = version;

  /// Sets the license information
  void setLicense(Map<String, dynamic> license) => _license = license;

  /// Sets the system boot time
  void setBoottime(String boottime) => _boottime = boottime;

  /// Sets the current system date/time
  void setDatetime(String datetime) => _datetime = datetime;

  /// Sets the system timezone
  void setTimezone(String timezone) => _timezone = timezone;

  /// Sets the system manufacturer
  void setSystemManufacturer(String? manufacturer) =>
      _systemManufacturer = manufacturer;

  /// Sets whether the system has ECC memory
  void setEccMemory(bool eccMemory) => _eccMemory = eccMemory;

  @override
  Map<String, Object?> build() {
    return {
      'version': _version,
      'buildtime': _buildtime,
      'hostname': _hostname,
      'physmem': _physmem,
      'model': _model,
      'cores': _cores,
      'physical_cores': _physicalCores,
      'loadavg': _loadavg,
      'uptime': _uptime,
      'uptime_seconds': _uptimeSeconds,
      'system_serial': _systemSerial,
      'system_product': _systemProduct,
      'system_product_version': _systemProductVersion,
      'license': _license ?? {},
      'boottime': _boottime,
      'datetime': _datetime,
      'timezone': _timezone,
      'system_manufacturer': _systemManufacturer,
      'ecc_memory': _eccMemory,
    };
  }
}

/// Builder for updating an existing SystemInfo instance.
class SystemInfoUpdateBuilder extends UpdateBuilder<SystemInfo> {
  final Map<String, Object?> _updates = {};

  /// Updates the TrueNAS version
  void setVersion(String version) => _updates['version'] = version;

  /// Updates the TrueNAS build time
  void setBuildtime(String buildtime) => _updates['buildtime'] = buildtime;

  /// Updates the system hostname
  void setHostname(String hostname) => _updates['hostname'] = hostname;

  /// Updates the physical memory in bytes
  void setPhysmem(int physmem) => _updates['physmem'] = physmem;

  /// Updates the CPU model
  void setModel(String model) => _updates['model'] = model;

  /// Updates the number of CPU cores
  void setCores(int cores) => _updates['cores'] = cores;

  /// Updates the number of physical CPU cores
  void setPhysicalCores(int physicalCores) =>
      _updates['physical_cores'] = physicalCores;

  /// Updates the system load averages
  void setLoadavg(List<dynamic> loadavg) => _updates['loadavg'] = loadavg;

  /// Updates the system uptime string
  void setUptime(String uptime) => _updates['uptime'] = uptime;

  /// Updates the system uptime in seconds
  void setUptimeSeconds(double uptimeSeconds) =>
      _updates['uptime_seconds'] = uptimeSeconds;

  /// Updates the system serial number
  void setSystemSerial(String? systemSerial) =>
      _updates['system_serial'] = systemSerial;

  /// Updates the system product name
  void setSystemProduct(String? systemProduct) =>
      _updates['system_product'] = systemProduct;

  /// Updates the system product version
  void setSystemProductVersion(String? version) =>
      _updates['system_product_version'] = version;

  /// Updates the license information
  void setLicense(Map<String, dynamic> license) =>
      _updates['license'] = license;

  /// Updates the system boot time
  void setBoottime(String boottime) => _updates['boottime'] = boottime;

  /// Updates the current system date/time
  void setDatetime(String datetime) => _updates['datetime'] = datetime;

  /// Updates the system timezone
  void setTimezone(String timezone) => _updates['timezone'] = timezone;

  /// Updates the system manufacturer
  void setSystemManufacturer(String? manufacturer) =>
      _updates['system_manufacturer'] = manufacturer;

  /// Updates whether the system has ECC memory
  void setEccMemory(bool eccMemory) => _updates['ecc_memory'] = eccMemory;

  @override
  Map<String, Object?> build() => _updates;
}
