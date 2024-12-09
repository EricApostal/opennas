/// Represents advanced system configuration
class SystemAdvancedConfig {
  final bool advancedmode;
  final bool autotune;
  final bool? kdumpEnabled;
  final int bootScrub;
  final bool consolemenu;
  final bool consolemsg;
  final bool debugkernel;
  final bool fqdnSyslog;
  final String motd;
  final String? loginBanner;
  final bool powerdaemon;
  final bool serialconsole;
  final String serialport;
  final String serialspeed;
  final String? syslogserver;
  final String syslogTransport;
  final String sysloglevel;
  final bool traceback;
  final bool uploadcrash;
  final int id;

  SystemAdvancedConfig({
    required this.advancedmode,
    required this.autotune,
    this.kdumpEnabled,
    required this.bootScrub,
    required this.consolemenu,
    required this.consolemsg,
    required this.debugkernel,
    required this.fqdnSyslog,
    required this.motd,
    this.loginBanner,
    required this.powerdaemon,
    required this.serialconsole,
    required this.serialport,
    required this.serialspeed,
    this.syslogserver,
    required this.syslogTransport,
    required this.sysloglevel,
    required this.traceback,
    required this.uploadcrash,
    required this.id,
  });
}
