import 'dart:io';
import 'package:dio/dio.dart';
import '../error/failure.dart';

class NetworkException implements Exception {
  static Failure handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure('Request timeout. Please try again.');

      case DioExceptionType.connectionError:
        return _handleConnectionError(exception);

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      case DioExceptionType.cancel:
        return const UnexpectedFailure('Request was cancelled.');

      case DioExceptionType.unknown:
      default:
        return UnexpectedFailure(
          'Unexpected error: ${exception.message ?? "Unknown error"}',
        );
    }
  }

  static Failure _handleConnectionError(DioException exception) {
    if (exception.error is SocketException) {
      return const NetworkFailure(
        'No internet connection. Please check your network.',
      );
    }
    return const NetworkFailure('Connection failed. Please try again.');
  }

  static Failure _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;
    if (statusCode == null) {
      return const ServerFailure('Unexpected server response.');
    }

    if (statusCode >= 400 && statusCode < 500) {
      return ClientFailure(
        'Client error: ${exception.response?.statusMessage ?? "Bad request"}',
      );
    }
    if (statusCode >= 500) {
      return const ServerFailure('Server error. Please try again later.');
    }
    return const ServerFailure('Unexpected server response.');
  }

  static bool shouldRetry(DioException exception) {
    return exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout ||
        (exception.type == DioExceptionType.connectionError &&
            exception.error is SocketException);
  }
}
