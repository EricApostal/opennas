/// Model class for Active Directory configuration
class ActiveDirectoryConfig {
  final String domainName;
  final String bindName;
  final bool verboseLogging;
  final bool useDefaultDomain;
  final bool allowTrustedDoms;
  final bool allowDnsUpdates;
  final bool disableFreenasCache;
  final bool restrictPam;
  final String? site;
  final int? kerberosRealm;
  final String? kerberosPrincipal;
  final int timeout;
  final int dnsTimeout;
  final String? nssInfo;
  final String createComputer;
  final String netBiosName;
  final String? netBiosNameB;
  final List<String> netBiosAlias;
  final bool enable;

  ActiveDirectoryConfig({
    required this.domainName,
    required this.bindName,
    required this.verboseLogging,
    required this.useDefaultDomain,
    required this.allowTrustedDoms,
    required this.allowDnsUpdates,
    required this.disableFreenasCache,
    required this.restrictPam,
    this.site,
    this.kerberosRealm,
    this.kerberosPrincipal,
    required this.timeout,
    required this.dnsTimeout,
    this.nssInfo,
    required this.createComputer,
    required this.netBiosName,
    this.netBiosNameB,
    required this.netBiosAlias,
    required this.enable,
  });
}
