import 'package:nasbridge/src/builders/builder.dart';
import 'package:nasbridge/src/models/system/advanced_config.dart';

/// Builder for creating/updating advanced system configuration
class SystemAdvancedConfigUpdateBuilder
    extends UpdateBuilder<SystemAdvancedConfig> {
  final Map<String, Object?> _updates = {};

  void setAdvancedmode(bool value) => _updates['advancedmode'] = value;
  void setAutotune(bool value) => _updates['autotune'] = value;
  void setKdumpEnabled(bool value) => _updates['kdump_enabled'] = value;
  void setBootScrub(int value) => _updates['boot_scrub'] = value;
  void setConsolemenu(bool value) => _updates['consolemenu'] = value;
  void setConsolemsg(bool value) => _updates['consolemsg'] = value;
  void setDebugkernel(bool value) => _updates['debugkernel'] = value;
  void setFqdnSyslog(bool value) => _updates['fqdn_syslog'] = value;
  void setMotd(String value) => _updates['motd'] = value;
  void setLoginBanner(String value) => _updates['login_banner'] = value;
  void setPowerdaemon(bool value) => _updates['powerdaemon'] = value;
  void setSerialconsole(bool value) => _updates['serialconsole'] = value;
  void setSerialport(String value) => _updates['serialport'] = value;
  void setSerialspeed(String value) => _updates['serialspeed'] = value;
  void setSyslogserver(String? value) => _updates['syslogserver'] = value;
  void setSyslogTransport(String value) => _updates['syslog_transport'] = value;
  void setSysloglevel(String value) => _updates['sysloglevel'] = value;
  void setTraceback(bool value) => _updates['traceback'] = value;
  void setUploadcrash(bool value) => _updates['uploadcrash'] = value;

  @override
  Map<String, Object?> build() => _updates;
}
