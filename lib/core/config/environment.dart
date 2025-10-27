enum Environment {
  dev('dev'),
  staging('staging'),
  production('production');

  const Environment(this.value);
  
  final String value;
  
  static Environment get current {
    const envValue = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'dev',
    );
    
    return Environment.values.firstWhere(
      (env) => env.value == envValue,
      orElse: () => Environment.dev,
    );
  }
  
  static bool get isDev => current == Environment.dev;
  static bool get isStaging => current == Environment.staging;
  static bool get isProduction => current == Environment.production;
  
  @override
  String toString() => value;
}