import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  final SharedPreferences _prefs;

  PersistentStorage(this._prefs);

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setString(String key, String? value) async {
    if (value == null) {
      await _prefs.remove(key);
      return;
    }
    await _prefs.setString(key, value);
  }

  Map<String, dynamic>? getJson(String key) {
    final value = _prefs.getString(key);
    if (value == null) return null;
    final jsonObject = jsonDecode(value);
    return jsonObject;
  }

  T? getObject<T>(
    String key,
    T Function(Map<String, dynamic> map) serializer,
  ) {
    final jsonObject = getJson(key);
    if (jsonObject == null) {
      return null;
    }
    final object = serializer(jsonObject);
    return object;
  }

  Future<void> setJson(String key, Map<String, dynamic>? value) async {
    if (value == null) {
      await _prefs.remove(key);
      return;
    }
    await _prefs.setString(key, jsonEncode(value));
  }
}
