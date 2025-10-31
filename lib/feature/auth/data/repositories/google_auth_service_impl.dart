import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/user_storage_service.dart';
import 'package:travaly_app/feature/auth/domain/models/auth_user.dart';

class GoogleAuthServiceImpl implements GoogleAuthService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final UserStorageService _storage;

  GoogleAuthServiceImpl({
    required UserStorageService storage,
    GoogleSignIn? googleSignIn,
    FirebaseAuth? auth,
  })  : _storage = storage,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) return null;

    final authUser = AuthUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL,
    );

    await _storage.storeUser(authUser);
    return authUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _storage.clearUser();

  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final storedUser = await _storage.getStoredUser();
    if (storedUser != null) return storedUser;

    final user = _auth.currentUser;
    if (user != null) {
      final authUser = AuthUser(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL,
      );
      await _storage.storeUser(authUser);
      return authUser;
    }

    return null;
  }
}
