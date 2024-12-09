import 'package:opennas/core/network/dio_client.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@riverpod
DioClient dioClient(Ref ref) {
  return DioClient(
    baseUrl: 'http://192.168.80.128',
    token: null,
  );
}
