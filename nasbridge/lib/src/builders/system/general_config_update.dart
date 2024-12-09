import 'package:nasbridge/src/builders/builder.dart';
import 'package:nasbridge/src/models/system/general_config.dart';

/// Builder for creating/updating general system configuration
class SystemGeneralConfigUpdateBuilder
    extends UpdateBuilder<SystemGeneralConfig> {
  final Map<String, Object?> _updates = {};

  void setUiCertificate(int? value) => _updates['ui_certificate'] = value;
  void setUiHttpsport(int value) => _updates['ui_httpsport'] = value;
  void setUiHttpsredirect(bool value) => _updates['ui_httpsredirect'] = value;
  void setUiHttpsprotocols(List<String> value) =>
      _updates['ui_httpsprotocols'] = value;
  void setUiPort(int value) => _updates['ui_port'] = value;
  void setUiAddress(List<String> value) => _updates['ui_address'] = value;
  void setUiV6address(List<String> value) => _updates['ui_v6address'] = value;
  void setUiAllowlist(List<String> value) => _updates['ui_allowlist'] = value;
  void setUiConsolemsg(bool value) => _updates['ui_consolemsg'] = value;
  void setUiXFrameOptions(String value) =>
      _updates['ui_x_frame_options'] = value;
  void setKbdmap(String value) => _updates['kbdmap'] = value;
  void setLanguage(String value) => _updates['language'] = value;
  void setTimezone(String value) => _updates['timezone'] = value;
  void setUsageCollection(bool? value) => _updates['usage_collection'] = value;
  void setDsAuth(bool value) => _updates['ds_auth'] = value;
  void setRollbackTimeout(int? value) => _updates['rollback_timeout'] = value;
  void setUiRestartDelay(int? value) => _updates['ui_restart_delay'] = value;

  @override
  Map<String, Object?> build() => _updates;
}
