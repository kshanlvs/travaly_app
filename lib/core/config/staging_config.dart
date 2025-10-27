import 'app_config.dart';

class StagingConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.staging.hotelbooking.com';
  
  @override
  String get apiKey => 'staging_api_key_456';
  
  @override
  bool get enableLogging => true;
  
  @override
  int get connectTimeout => 30000;
  
  @override
  int get receiveTimeout => 30000;
}