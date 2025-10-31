import 'package:get_it/get_it.dart';
import 'package:travaly_app/core/config/app_config.dart';
import 'package:travaly_app/core/config/dev_config.dart';
import 'package:travaly_app/core/config/environment.dart';
import 'package:travaly_app/core/config/prod_config.dart';
import 'package:travaly_app/core/config/staging_config.dart';
import 'package:travaly_app/core/device/di/device_service_locator.dart';
import 'package:travaly_app/core/network/dio_client.dart';
import 'package:travaly_app/core/network/logger.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/core/storage/shared_preference_storage.dart';
import 'package:travaly_app/feature/auth/di/auth_service_locator.dart';
import 'package:travaly_app/feature/hotel/di/hotel_service_locator.dart';

final sl = GetIt.instance;
void setupDependencies() {
  final config = _getConfigForEnvironment();

  sl.registerLazySingleton<AppConfig>(() => config);
  sl.registerLazySingleton<NetworkClient>(() =>
      DioNetworkClient(sl<AppConfig>(), logger, sl<SharedPrefsStorage>()));
  setupAuthLocator();
  initHotelServiceLocator();

  setupDeviceLocator();
}

AppConfig _getConfigForEnvironment() {
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
