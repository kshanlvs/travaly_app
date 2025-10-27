import 'package:get_it/get_it.dart';
import 'package:travaly_app/core/storage/key_value_storage.dart';
import 'package:travaly_app/core/storage/shared_preference_storage.dart';
import 'package:travaly_app/feature/auth/data/services/shared_pref_storage_service.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/user_storage_service.dart';
import '../data/repositories/google_auth_service_impl.dart';

final slAuth = GetIt.instance;

void setupAuthLocator() {
  slAuth.registerLazySingleton<KeyValueStorage>(
    () => SharedPrefsStorage(),
  );

  slAuth.registerLazySingleton<UserStorageService>(
    () => SharedPrefsStorageService(slAuth<KeyValueStorage>()),
  );

  slAuth.registerLazySingleton<GoogleAuthService>(
    () => GoogleAuthServiceImpl(
      storage: slAuth<UserStorageService>(),
    ),
  );
}
