import 'package:freezed_annotation/freezed_annotation.dart';

part 'pool.freezed.dart';
part 'pool.g.dart';

@freezed
class Pool with _$Pool {
  const factory Pool({
    required String name,
    required String status,
    required bool isDecrypted,
  }) = _Pool;

  factory Pool.fromJson(Map<String, dynamic> json) => _$PoolFromJson(json);
}
