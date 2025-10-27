import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';
import '../../domain/models/auth_user.dart';

class GoogleAuthServiceImpl implements GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser?> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

 
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) return null;

    return AuthUser(
      id: user.uid,
      name: user.displayName,
      email: user.email ?? '',
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthUser(
      id: user.uid,
      name: user.displayName,
      email: user.email ?? '',
      photoUrl: user.photoURL,
    );
  }
}
