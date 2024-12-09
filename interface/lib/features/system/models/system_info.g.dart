// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SystemInfoImpl _$$SystemInfoImplFromJson(Map<String, dynamic> json) =>
    _$SystemInfoImpl(
      hostname: json['hostname'] as String,
      version: json['version'] as String,
      debugMode: json['debugMode'] as bool,
    );

Map<String, dynamic> _$$SystemInfoImplToJson(_$SystemInfoImpl instance) =>
    <String, dynamic>{
      'hostname': instance.hostname,
      'version': instance.version,
      'debugMode': instance.debugMode,
    };
