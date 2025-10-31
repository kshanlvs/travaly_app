import 'dart:convert';

import 'package:travaly_app/feature/auth/domain/interfaces/user_storage_service.dart';
import 'package:travaly_app/feature/auth/domain/models/auth_user.dart';
import 'package:travaly_app/core/storage/key_value_storage.dart';

class SharedPrefsStorageService implements UserStorageService {
  static const String _userKey = 'currentUser';
  final KeyValueStorage _storage;

  SharedPrefsStorageService(this._storage);

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
