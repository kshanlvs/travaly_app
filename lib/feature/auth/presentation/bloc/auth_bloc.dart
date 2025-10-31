import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/feature/auth/domain/models/auth_user.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuthService googleAuthService;

  AuthBloc(this.googleAuthService) : super(AuthInitial()) {
  
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);


  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final currentUser = await googleAuthService.getCurrentUser();

      if (currentUser != null) {
        emit(AuthSuccess(currentUser));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(
          'Failed to check authentication status: ${e.toString()}'));
    }
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
  emit(AuthLoggedOut()); 
}
}
