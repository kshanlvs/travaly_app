import 'package:get_it/get_it.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';
import '../data/repositories/google_auth_service_impl.dart';

final slAuth = GetIt.instance;

void setupAuthLocator() {
  slAuth.registerLazySingleton<GoogleAuthService>(
    () => GoogleAuthServiceImpl(),
  );
}
