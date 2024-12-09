/// Builder for updating Active Directory configuration
class ActiveDirectoryUpdateBuilder {
  final Map<String, Object?> _updates = {};

  void setDomainName(String value) => _updates['domainname'] = value;
  void setBindName(String value) => _updates['bindname'] = value;
  void setBindPw(String value) => _updates['bindpw'] = value;
  void setVerboseLogging(bool value) => _updates['verbose_logging'] = value;
  void setUseDefaultDomain(bool value) =>
      _updates['use_default_domain'] = value;
  void setAllowTrustedDoms(bool value) =>
      _updates['allow_trusted_doms'] = value;
  void setAllowDnsUpdates(bool value) => _updates['allow_dns_updates'] = value;
  void setDisableFreenasCache(bool value) =>
      _updates['disable_freenas_cache'] = value;
  void setRestrictPam(bool value) => _updates['restrict_pam'] = value;
  void setSite(String? value) => _updates['site'] = value;
  void setKerberosRealm(int? value) => _updates['kerberos_realm'] = value;
  void setKerberosPrincipal(String? value) =>
      _updates['kerberos_principal'] = value;
  void setTimeout(int value) => _updates['timeout'] = value;
  void setDnsTimeout(int value) => _updates['dns_timeout'] = value;
  void setNssInfo(String? value) => _updates['nss_info'] = value;
  void setCreatecomputer(String value) => _updates['createcomputer'] = value;
  void setNetbiosname(String value) => _updates['netbiosname'] = value;
  void setNetbiosnameB(String value) => _updates['netbiosname_b'] = value;
  void setNetbiosalias(List<String> value) => _updates['netbiosalias'] = value;
  void setEnable(bool value) => _updates['enable'] = value;

  Map<String, Object?> build() => _updates;
}
