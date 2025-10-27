
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/auth_user.dart';
import '../../domain/interfaces/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuthService googleAuthService;

  AuthBloc(this.googleAuthService) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await googleAuthService.signInWithGoogle();
      if (user == null) {
        emit(AuthFailure('User cancelled login'));
      } else {
        emit(AuthSuccess(user));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await googleAuthService.signOut();
    emit(AuthInitial());
  }
}
