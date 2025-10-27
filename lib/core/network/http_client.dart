import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:travaly_app/core/config/app_config.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/core/network/network_exception.dart';

class HttpNetworkClient implements NetworkClient {
  final AppConfig _config;
  final Logger _logger;
  final http.Client _client;

  HttpNetworkClient(this._config, this._logger) : _client = http.Client();

  Map<String, String> _getHeaders(Map<String, dynamic>? additionalHeaders) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-API-Key': _config.apiKey,
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders.cast<String, String>());
    }

    return headers;
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final uri = Uri.parse(_config.baseUrl + path).replace(
        queryParameters: queryParameters?.cast<String, String>(),
      );

      if (_config.enableLogging) {
        _logger.d('🌐 HTTP GET: $uri');
      }

      final response = await _client
          .get(
            uri,
            headers: _getHeaders(headers),
          )
          .timeout(
            Duration(milliseconds: _config.connectTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
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
      final uri = Uri.parse(_config.baseUrl + path).replace(
        queryParameters: queryParameters?.cast<String, String>(),
      );

      if (_config.enableLogging) {
        _logger.d('🌐 HTTP POST: $uri\nData: $data');
      }

      final response = await _client
          .post(
            uri,
            headers: _getHeaders(headers),
            body: jsonEncode(data),
          )
          .timeout(
            Duration(milliseconds: _config.connectTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Implement put and delete similarly...

  dynamic _handleResponse(http.Response response) {
    if (_config.enableLogging) {
      _logger.i(
          '✅ HTTP RESPONSE: ${response.statusCode} ${response.request?.url}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw NetworkException.httpError(
        response.statusCode,
        response.body,
      );
    }
  }

  NetworkException _handleError(dynamic error) {
    if (error is http.ClientException) {
      return NetworkException.noInternet(error.message);
    } else if (error is NetworkException) {
      return error;
    } else {
      return NetworkException.unknown(error.toString());
    }
  }

  @override
  Future delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
