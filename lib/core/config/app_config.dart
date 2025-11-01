import 'package:travaly_app/core/config/dev_config.dart';
import 'package:travaly_app/core/config/environment.dart';
import 'package:travaly_app/core/config/prod_config.dart';
import 'package:travaly_app/core/config/staging_config.dart';

abstract class AppConfig {
  String get baseUrl;
  String get apiKey;
  bool get enableLogging;
  int get connectTimeout;
  int get receiveTimeout;
  String get authToken;

  factory AppConfig() {
    switch (Environment.current) {
      case Environment.dev:
        return DevConfig();
      case Environment.staging:
        return StagingConfig();
      case Environment.production:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
