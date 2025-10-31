import 'package:get_it/get_it.dart';
import 'package:travaly_app/core/device/device_info_service.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/core/storage/shared_preference_storage.dart';
import 'package:travaly_app/feature/device/data/repositories/device_repository_impl.dart';
import 'package:travaly_app/feature/device/domain/repositories/device_repository.dart';
import 'package:travaly_app/core/device/presentation/bloc/device_bloc.dart';

final slDevice = GetIt.instance;

void setupDeviceLocator() {
  slDevice
      .registerLazySingleton<SharedPrefsStorage>(() => SharedPrefsStorage());
  slDevice.registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());

  slDevice.registerLazySingleton<DeviceRegistrationService>(
    () => DeviceRepositoryImpl(slDevice<NetworkClient>()),
  );

  slDevice.registerFactory<DeviceBloc>(
    () => DeviceBloc(
      slDevice<DeviceRegistrationService>(),
      slDevice<SharedPrefsStorage>(),
      slDevice<DeviceInfoService>(),
    ),
  );
}
