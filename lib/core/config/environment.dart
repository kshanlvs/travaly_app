abstract class Environment {
  static const dev = 'dev';
  static const staging = 'staging';
  static const production = 'production';
  
  static String get current => const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: dev,
  );
  
  static bool get isDev => current == dev;
  static bool get isStaging => current == staging;
  static bool get isProduction => current == production;
}

