import 'package:dio/dio.dart';
import 'package:opennas/core/network/dio_client.dart';
import 'package:opennas/core/exceptions/truenas_exception.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<String> generateToken({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.client.post(
        '/auth/generate_token',
        data: {'username': username, 'password': password},
      );
      return response.data['token'];
    } on DioException catch (e) {
      throw AuthException.fromDioError(e);
    }
  }
}
