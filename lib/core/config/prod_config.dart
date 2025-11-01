import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travaly_app/core/config/app_config.dart';

class ProdConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.mytravaly.com';

  @override
  String get apiKey => 'prod_api_key_789';

  @override
  bool get enableLogging => false;

  @override
  int get connectTimeout => 15000;

  @override
  int get receiveTimeout => 15000;

  @override
  String get authToken =>
      dotenv.get('AUTH_TOKEN', fallback: '71523fdd8d26f585315b4233e39d9263');
}
