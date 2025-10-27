import 'package:travaly_app/core/config/app_config.dart';

class DevConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.dev.hotelbooking.com';

  @override
  String get apiKey => 'dev_api_key_123';

  @override
  bool get enableLogging => true;

  @override
  int get connectTimeout => 30000;

  @override
  int get receiveTimeout => 30000;
}
