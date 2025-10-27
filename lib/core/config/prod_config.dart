
import 'package:travaly_app/core/config/app_config.dart';

class ProdConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.hotelbooking.com';
  
  @override
  String get apiKey => 'prod_api_key_789';
  
  @override
  bool get enableLogging => false;
  
  @override
  int get connectTimeout => 15000;
  
  @override
  int get receiveTimeout => 15000;
}