import 'package:travaly_app/feature/auth/domain/models/auth_user.dart';

abstract class GoogleAuthService {
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
  Future<AuthUser?> getCurrentUser();
}

abstract class FacebookAuthService {
  Future<AuthUser?> signInWithFacebook();
  Future<void> signOut();
  Future<AuthUser?> getCurrentUser();
}

abstract class AppleAuthService {
  Future<AuthUser?> signInWithApple();
  Future<void> signOut();
  Future<AuthUser?> getCurrentUser();
}
