import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travaly_app/core/config/app_config.dart';

class DevConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.mytravaly.com';

  @override
  String get apiKey => 'dev_api_key_123';

  @override
  bool get enableLogging => true;

  @override
  int get connectTimeout => 30000;

  @override
  int get receiveTimeout => 30000;

  @override
  String get authToken =>
      dotenv.get('AUTH_TOKEN', fallback: '71523fdd8d26f585315b4233e39d9263');
}
