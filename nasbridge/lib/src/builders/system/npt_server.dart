import 'package:nasbridge/src/builders/builder.dart';
import 'package:nasbridge/src/models/system/nptserver.dart';

/// Builder for creating a new NTP server
class NtpServerBuilder extends CreateBuilder<NtpServer> {
  String? _address;
  bool _burst = false;
  bool _iburst = true;
  bool _prefer = false;
  int _minpoll = 6;
  int _maxpoll = 10;
  bool? _force;

  void setAddress(String value) => _address = value;
  void setBurst(bool value) => _burst = value;
  void setIburst(bool value) => _iburst = value;
  void setPrefer(bool value) => _prefer = value;
  void setMinpoll(int value) => _minpoll = value;
  void setMaxpoll(int value) => _maxpoll = value;
  void setForce(bool value) => _force = value;

  @override
  Map<String, Object?> build() {
    return {
      'address': _address,
      'burst': _burst,
      'iburst': _iburst,
      'prefer': _prefer,
      'minpoll': _minpoll,
      'maxpoll': _maxpoll,
      if (_force != null) 'force': _force,
    };
  }
}

/// Builder for updating an existing NTP server
class NtpServerUpdateBuilder extends UpdateBuilder<NtpServer> {
  final Map<String, Object?> _updates = {};

  void setAddress(String value) => _updates['address'] = value;
  void setBurst(bool value) => _updates['burst'] = value;
  void setIburst(bool value) => _updates['iburst'] = value;
  void setPrefer(bool value) => _updates['prefer'] = value;
  void setMinpoll(int value) => _updates['minpoll'] = value;
  void setMaxpoll(int value) => _updates['maxpoll'] = value;
  void setForce(bool value) => _updates['force'] = value;

  @override
  Map<String, Object?> build() => _updates;
}
