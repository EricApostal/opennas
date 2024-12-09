/// Model class for domain information
class DomainInfo {
  final String ldapServer;
  final String ldapServerName;
  final String realm;
  final int ldapPort;
  final String serverTime;
  final String kdcServer;
  final int serverTimeOffset;
  final String lastPasswordChange;

  DomainInfo({
    required this.ldapServer,
    required this.ldapServerName,
    required this.realm,
    required this.ldapPort,
    required this.serverTime,
    required this.kdcServer,
    required this.serverTimeOffset,
    required this.lastPasswordChange,
  });
}
