/// Represents general system configuration
class SystemGeneralConfig {
  final int id;
  final Map<String, dynamic> uiCertificate;
  final int uiHttpsport;
  final bool uiHttpsredirect;
  final List<String> uiHttpsprotocols;
  final int uiPort;
  final List<String> uiAddress;
  final List<String> uiV6address;
  final List<String>? uiAllowlist;
  final bool? uiConsolemsg;
  final String? uiXFrameOptions;
  final String kbdmap;
  final String language;
  final String timezone;
  final bool? usageCollection;
  final bool wizardshown;
  final bool? dsAuth;

  SystemGeneralConfig({
    required this.id,
    required this.uiCertificate,
    required this.uiHttpsport,
    required this.uiHttpsredirect,
    required this.uiHttpsprotocols,
    required this.uiPort,
    required this.uiAddress,
    required this.uiV6address,
    this.uiAllowlist,
    this.uiConsolemsg,
    this.uiXFrameOptions,
    required this.kbdmap,
    required this.language,
    required this.timezone,
    this.usageCollection,
    required this.wizardshown,
    this.dsAuth,
  });
}
