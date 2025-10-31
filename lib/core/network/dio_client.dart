import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travaly_app/core/config/app_config.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/core/network/network_exception.dart';
import 'package:travaly_app/core/storage/shared_preference_storage.dart'; // Import your storage

class DioNetworkClient implements NetworkClient {
  final Dio _dio;
  final Logger _logger;
  final AppConfig _config;
  final SharedPrefsStorage _localStorage;

  DioNetworkClient(
    this._config,
    this._logger,
    this._localStorage, 
  ) : _dio = Dio(
          BaseOptions(
            baseUrl: _config.baseUrl,
            connectTimeout: Duration(milliseconds: _config.connectTimeout),
            receiveTimeout: Duration(milliseconds: _config.receiveTimeout),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'X-API-Key': _config.apiKey,
            },
          ),
        ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
      
          final visitorToken = await _localStorage.getString('visitors_token');
          if (visitorToken != null && visitorToken.isNotEmpty) {
            options.headers['visitortoken'] = visitorToken;
          }

          if (_config.enableLogging) {
            _logger.d(
              'REQUEST: ${options.method} ${options.uri}\n'
              'Headers: ${options.headers}\n'
              'Data: ${options.data}',
            );
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (_config.enableLogging) {
            _logger.i(
              'RESPONSE: ${response.statusCode}'
              ' ${response.requestOptions.uri}\n'
              'Data: ${response.data}',
            );
          }
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (_config.enableLogging) {
            _logger.e(
              'ERROR: ${error.type} ${error.response?.statusCode}'
              ' ${error.requestOptions.uri}\n'
              'Message: ${error.message}\n'
              'Response: ${error.response?.data}',
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  NetworkException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException.timeout(error.message);
      case DioExceptionType.badResponse:
        return NetworkException.httpError(
          error.response?.statusCode,
          error.response?.data?.toString(),
        );
      case DioExceptionType.cancel:
        return NetworkException.cancelled(error.message);
      case DioExceptionType.unknown:
        return NetworkException.noInternet(error.message);
      default:
        return NetworkException.unknown(error.message);
    }
  }
}