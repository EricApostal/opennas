import 'package:dio/dio.dart';

class BaseTrueNasException implements Exception {
  final String message;
  final int? statusCode;

  BaseTrueNasException(this.message, {this.statusCode});

  factory BaseTrueNasException.fromDioError(DioException error) {
    return BaseTrueNasException(
      error.message ?? 'Unknown error occurred',
      statusCode: error.response?.statusCode,
    );
  }
}

class AuthException extends BaseTrueNasException {
  AuthException(super.message, {super.statusCode});

  factory AuthException.fromDioError(DioException error) {
    return AuthException(
      error.message ?? 'Unknown error occurred',
      statusCode: error.response?.statusCode,
    );
  }
}

class SystemException extends BaseTrueNasException {
  SystemException(super.message, {super.statusCode});

  factory SystemException.fromDioError(DioException error) {
    return SystemException(
      error.message ?? 'Unknown error occurred',
      statusCode: error.response?.statusCode,
    );
  }
}

class StorageException extends BaseTrueNasException {
  StorageException(super.message, {super.statusCode});

  factory StorageException.fromDioError(DioException error) {
    return StorageException(
      error.message ?? 'Unknown error occurred',
      statusCode: error.response?.statusCode,
    );
  }
}
