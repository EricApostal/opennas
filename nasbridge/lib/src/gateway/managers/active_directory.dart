// active_directory_manager.dart
import 'package:nasbridge/src/builders/active_directory/active_directory.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/gateway/managers/manager.dart';
import 'package:nasbridge/src/models/active_directory/active_directory.dart';
import 'package:nasbridge/src/models/active_directory/domain_info.dart';

/// Manager class for handling Active Directory operations through the TrueNAS API.
class ActiveDirectoryManager extends Manager<ActiveDirectoryConfig> {
  /// Creates a new instance of [ActiveDirectoryManager].
  ActiveDirectoryManager(super.client);

  /// Forces an update of the AD machine account password.
  Future<void> changeTrustAccountPassword() async {
    final gatewayClient = client as NasbridgeGateway;
    await gatewayClient.sendMethod('activedirectory.change_trust_account_pw');
  }

  /// Gets current Active Directory configuration.
  Future<ActiveDirectoryConfig> getConfig() async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient.sendMethod('activedirectory.config');
    return parseActiveDirectoryConfig(response as Map<String, Object?>);
  }

  /// Gets information about the currently joined domain.
  Future<DomainInfo?> getDomainInfo([String domain = '']) async {
    final gatewayClient = client as NasbridgeGateway;
    final response =
        await gatewayClient.sendMethod('activedirectory.domain_info', [domain]);
    if (response == null) return null;

    return parseDomainInfo(response as Map<String, Object?>);
  }

  /// Gets list of kerberos SPN entries.
  Future<List<String>?> getSpnList() async {
    final gatewayClient = client as NasbridgeGateway;
    final response =
        await gatewayClient.sendMethod('activedirectory.get_spn_list');
    if (response == null) return null;
    return (response as List<dynamic>).cast<String>();
  }

  /// Gets the state of the Active Directory service.
  Future<String> getState() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('activedirectory.get_state')
        as String;
  }

  /// Leaves Active Directory domain.
  Future<void> leave({String? username, String? password}) async {
    final gatewayClient = client as NasbridgeGateway;
    final Map<String, dynamic> credentials = {};
    if (username != null) credentials['username'] = username;
    if (password != null) credentials['password'] = password;
    await gatewayClient.sendMethod('activedirectory.leave', [credentials]);
  }

  /// Gets available LDAP schema choices.
  Future<List<dynamic>> getNssInfoChoices() async {
    final gatewayClient = client as NasbridgeGateway;
    final response =
        await gatewayClient.sendMethod('activedirectory.nss_info_choices');
    return (response as List<dynamic>);
  }

  /// Checks if secure channel connection to domain controller is alive.
  Future<bool> isStarted() async {
    final gatewayClient = client as NasbridgeGateway;
    return await gatewayClient.sendMethod('activedirectory.started') as bool;
  }

  /// Updates Active Directory configuration.
  Future<ActiveDirectoryConfig?> update(
      ActiveDirectoryUpdateBuilder builder) async {
    final gatewayClient = client as NasbridgeGateway;
    final response = await gatewayClient
        .sendMethod('activedirectory.update', [builder.build()]);
    // not sure if this is always null
    if (response == null) return null;
    return parseActiveDirectoryConfig(response as Map<String, Object?>);
  }

  /// Parses Active Directory configuration response
  ActiveDirectoryConfig parseActiveDirectoryConfig(Map<String, Object?> raw) {
    return ActiveDirectoryConfig(
      domainName: raw['domainname'] as String,
      bindName: raw['bindname'] as String,
      verboseLogging: raw['verbose_logging'] as bool,
      useDefaultDomain: raw['use_default_domain'] as bool,
      allowTrustedDoms: raw['allow_trusted_doms'] as bool,
      allowDnsUpdates: raw['allow_dns_updates'] as bool,
      disableFreenasCache: raw['disable_freenas_cache'] as bool,
      restrictPam: raw['restrict_pam'] as bool,
      site: raw['site'] as String?,
      kerberosRealm: raw['kerberos_realm'] as int?,
      kerberosPrincipal: raw['kerberos_principal'] as String?,
      timeout: raw['timeout'] as int,
      dnsTimeout: raw['dns_timeout'] as int,
      nssInfo: raw['nss_info'] as String?,
      createComputer: raw['createcomputer'] as String,
      netBiosName: raw['netbiosname'] as String,
      netBiosNameB: raw['netbiosname_b'] as String?,
      netBiosAlias:
          (raw['netbiosalias'] as List<dynamic>?)?.cast<String>() ?? [],
      enable: raw['enable'] as bool,
    );
  }

  /// Parses domain info response
  DomainInfo parseDomainInfo(Map<String, Object?> raw) {
    return DomainInfo(
      ldapServer: raw['LDAP server'] as String,
      ldapServerName: raw['LDAP server name'] as String,
      realm: raw['Realm'] as String,
      ldapPort: raw['LDAP port'] as int,
      serverTime: raw['Server time'] as String,
      kdcServer: raw['KDC server'] as String,
      serverTimeOffset: raw['Server time offset'] as int,
      lastPasswordChange: raw['Last machine account password change'] as String,
    );
  }
}
