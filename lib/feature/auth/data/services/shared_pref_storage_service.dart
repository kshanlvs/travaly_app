import 'dart:convert';

import '../../domain/interfaces/user_storage_service.dart';
import '../../domain/models/auth_user.dart';
import '../../../../core/storage/key_value_storage.dart'; // Import abstraction

class SharedPrefsStorageService implements UserStorageService {
  static const String _userKey = 'currentUser';
  final KeyValueStorage _storage; // Depend on abstraction

  SharedPrefsStorageService(this._storage); // Inject dependency

  @override
  Future<void> storeUser(AuthUser user) async {
    await _storage.setString(_userKey, json.encode(user.toJson()));
  }

  @override
  Future<AuthUser?> getStoredUser() async {
    try {
      final userJson = await _storage.getString(_userKey);
      if (userJson != null) {
        return AuthUser.fromJson(json.decode(userJson) as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    await _storage.remove(_userKey);
  }
}
