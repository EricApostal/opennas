import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_info.freezed.dart';
part 'system_info.g.dart';

@freezed
class SystemInfo with _$SystemInfo {
  const factory SystemInfo({
    required String hostname,
    required String version,
    required bool debugMode,
  }) = _SystemInfo;

  factory SystemInfo.fromJson(Map<String, dynamic> json) =>
      _$SystemInfoFromJson(json);
}
