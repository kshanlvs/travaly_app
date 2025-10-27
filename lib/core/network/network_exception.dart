class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? response;

  const NetworkException({
    required this.message,
    this.statusCode,
    this.response,
  });

  factory NetworkException.timeout([String? message]) =>
      NetworkException(message: message ?? 'Request timed out');

  factory NetworkException.httpError(int? statusCode, [String? response]) =>
      NetworkException(
        message: 'HTTP error occurred',
        statusCode: statusCode,
        response: response,
      );

  factory NetworkException.noInternet([String? message]) =>
      NetworkException(message: message ?? 'No internet connection');

  factory NetworkException.cancelled([String? message]) =>
      NetworkException(message: message ?? 'Request cancelled');

  factory NetworkException.unknown([String? message]) =>
      NetworkException(message: message ?? 'Unknown network error');

  @override
  String toString() => 'NetworkException: $message';
}
