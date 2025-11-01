abstract class KeyValueStorage {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);

  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);

  Future<void> remove(String key);
  Future<bool> containsKey(String key);
  Future<void> clear();
}
