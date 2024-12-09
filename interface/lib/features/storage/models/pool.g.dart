// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoolImpl _$$PoolImplFromJson(Map<String, dynamic> json) => _$PoolImpl(
      name: json['name'] as String,
      status: json['status'] as String,
      isDecrypted: json['isDecrypted'] as bool,
    );

Map<String, dynamic> _$$PoolImplToJson(_$PoolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'isDecrypted': instance.isDecrypted,
    };
