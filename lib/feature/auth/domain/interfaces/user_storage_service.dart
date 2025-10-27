import 'package:travaly_app/feature/auth/domain/models/auth_user.dart';

abstract class UserStorageService {
  Future<void> storeUser(AuthUser user);
  Future<AuthUser?> getStoredUser();
  Future<void> clearUser();
}
