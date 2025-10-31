abstract class KeyValueStorage {
  // String methods
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);

  // Bool methods
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);

  // Common methods
  Future<void> remove(String key);
  Future<bool> containsKey(String key);
  Future<void> clear();
}
