import 'package:nasbridge/src/builders/builder.dart';
import 'package:nasbridge/src/models/system/security.dart';

/// Builder for updating system security configuration
class SystemSecurityUpdateBuilder extends UpdateBuilder<SystemSecurity> {
  bool? _enableFips;

  void setEnableFips(bool value) => _enableFips = value;

  @override
  Map<String, Object?> build() {
    return {
      if (_enableFips != null) 'enable_fips': _enableFips,
    };
  }
}
