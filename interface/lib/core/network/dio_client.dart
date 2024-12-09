import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient({required String baseUrl, String? token}) {
    _dio = Dio(BaseOptions(
      baseUrl: '$baseUrl/api/v2.0',
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
    ));
  }

  Dio get client => _dio;
}
