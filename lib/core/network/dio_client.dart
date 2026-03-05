import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'network_exceptions.dart';

class DioClient {
  late final Dio _dio;
  static const int _maxRetries = 2;
  static const Duration _retryDelay = Duration(milliseconds: 500);

  DioClient() {
    _dio = Dio(_createBaseOptions());
    _setupInterceptors();
  }

  BaseOptions _createBaseOptions() {
    final baseUrl = dotenv.env['BASE_URL'];
    final apiVersion = dotenv.env['API_VERSION'];

    if (baseUrl == null) {
      throw Exception('BASE_URL is not set in .env file');
    }
    if (apiVersion == null) {
      throw Exception('API_VERSION is not set in .env file');
    }

    return BaseOptions(
      baseUrl: '$baseUrl$apiVersion',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          final retryCount = error.requestOptions.extra['retryCount'] ?? 0;

          if (NetworkException.shouldRetry(error) && retryCount < _maxRetries) {
            error.requestOptions.extra['retryCount'] = retryCount + 1;
            await Future.delayed(_retryDelay);

            try {
              final response = await _dio.fetch(error.requestOptions);
              handler.resolve(response);
              return;
            } on DioException catch (e) {
              handler.next(e);
              return;
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<Response<T>> _makeRequest<T>(
    Future<Response<T>> Function() apiCall,
  ) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      throw NetworkException.handleDioException(e);
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _makeRequest(
      () =>
          _dio.get<T>(path, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _makeRequest(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }
}
