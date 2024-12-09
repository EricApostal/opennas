import 'package:dio/dio.dart';
import 'package:opennas/core/network/dio_client.dart';
import 'package:opennas/core/exceptions/truenas_exception.dart';
import 'package:opennas/features/system/models/system_info.dart';

class SystemRepository {
  final DioClient _dioClient;

  SystemRepository(this._dioClient);

  Future<SystemInfo> getSystemInfo() async {
    try {
      final response = await _dioClient.client.get('/system/info');
      return SystemInfo.fromJson(response.data);
    } on DioException catch (e) {
      throw SystemException.fromDioError(e);
    }
  }

  Future<bool> getDebugMode() async {
    try {
      final response = await _dioClient.client.get('/core/debug_mode_enabled');
      return response.data as bool;
    } on DioException catch (e) {
      throw SystemException.fromDioError(e);
    }
  }
}
