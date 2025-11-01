import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/user_storage_service.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserStorageService _userStorageService;

  UserCubit(this._userStorageService) : super(UserInitial());

  Future<void> loadUser() async {
    emit(UserLoading());
    try {
      final user = await _userStorageService.getStoredUser();
      final userName = user?.name.isNotEmpty == true ? user?.name : 'Guest';
      emit(UserLoaded(userName ?? ''));
    } catch (e) {
      emit(UserError('Failed to load user'));
    }
  }

  Future<void> clearUser() async {
    try {
      await _userStorageService.clearUser();
      emit(UserLoaded('Guest'));
    } catch (e) {
      emit(UserError('Failed to clear user'));
    }
  }

  Future<void> refresh() async => loadUser();
}
