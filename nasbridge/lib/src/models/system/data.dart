/// Represents system information for a TrueNAS system.
///
/// This model contains various system metrics and information including hardware
/// specifications, system status, and configuration details.
class SystemInfo {
  /// The version of TrueNAS currently installed
  final String version;

  /// The build timestamp of the installed TrueNAS version
  final int buildtime;

  /// The system's configured hostname
  final String hostname;

  /// Total physical memory in bytes
  final int physmem;

  /// The CPU model identification string
  final String model;

  /// Total number of CPU cores (including virtual cores)
  final int cores;

  /// Number of physical CPU cores (excluding virtual cores)
  final int? physicalCores;

  /// System load averages
  ///
  /// Typically contains 1, 5, and 15 minute load averages
  final List<dynamic> loadavg;

  /// System uptime in human-readable format
  final String uptime;

  /// System uptime in seconds
  final double uptimeSeconds;

  /// System serial number
  ///
  /// May be null if the system serial cannot be determined
  final String? systemSerial;

  /// System product name
  ///
  /// May be null if the product information cannot be determined
  final String? systemProduct;

  /// System product version
  ///
  /// May be null if the product version cannot be determined
  final String? systemProductVersion;

  /// TrueNAS license information
  ///
  /// Contains license details for TrueNAS Enterprise editions
  final Map<String, dynamic> license;

  /// System boot time in ISO format
  final int boottime;

  /// Current system date and time in ISO format
  final int datetime;

  /// Configured system timezone
  final String timezone;

  /// System manufacturer name
  ///
  /// May be null if the manufacturer information cannot be determined
  final String? systemManufacturer;

  /// Indicates whether the system has ECC memory
  final bool eccMemory;

  /// Creates a new [SystemInfo] instance with the provided values.
  ///
  /// All parameters are required except for [systemSerial], [systemProduct],
  /// [systemProductVersion], [license], and [systemManufacturer] which may be null.
  SystemInfo({
    required this.version,
    required this.buildtime,
    required this.hostname,
    required this.physmem,
    required this.model,
    required this.cores,
    required this.physicalCores,
    required this.loadavg,
    required this.uptime,
    required this.uptimeSeconds,
    this.systemSerial,
    this.systemProduct,
    this.systemProductVersion,
    this.license = const {},
    required this.boottime,
    required this.datetime,
    required this.timezone,
    this.systemManufacturer,
    required this.eccMemory,
  });

  @override
  String toString() {
    return 'SystemInfo(version: $version, hostname: $hostname, model: $model, cores: $cores, physicalCores: $physicalCores)';
  }
}
