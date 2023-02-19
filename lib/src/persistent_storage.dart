// import 'dart:convert';

// import 'package:injectable/injectable.dart';
// import 'package:latin_library/modules/app/models/session.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// @singleton
// class PersistentStorage {
//   final SharedPreferences _prefs;

//   PersistentStorage(this._prefs);

//   Future<void> _setString(String key, String? value) async {
//     if (value == null) {
//       await _prefs.remove(key);
//       return;
//     }
//     await _prefs.setString(key, value);
//   }

//   Future<void> _setJson(String key, Map<String, dynamic>? value) async {
//     if (value == null) {
//       await _prefs.remove(key);
//       return;
//     }
//     await _prefs.setString(key, jsonEncode(value));
//   }

//   String? getToken() {
//     return _prefs.getString('token');
//   }

//   Future<void> setToken(String? value) async {
//     await _setString('token', value);
//   }

//   String? getAdminToken() {
//     return _prefs.getString('admin_token');
//   }

//   Future<void> setAdminToken(String? value) async {
//     await _setString('admin_token', value);
//   }

//   User? getUser() {
//     final value = _prefs.getString('user');
//     if (value == null) return null;
//     final json = jsonDecode(value);
//     return User.fromJson(json);
//   }

//   Future<void> setUser(User? value) async {
//     _setJson('user', value?.toJson());
//   }

//   Institution? getInstitution() {
//     final value = _prefs.getString('institution');
//     if (value == null) return null;
//     final json = jsonDecode(value);
//     return Institution.fromJson(json);
//   }

//   Future<void> setInstitution(Institution? value) async {
//     _setJson('institution', value?.toJson());
//   }

//   String? getInstitutionSubdomain() {
//     return _prefs.getString('institutionSubdomain');
//   }

//   Future<void> setInstitutionSubdomain(String? value) async {
//     await _setString('institutionSubdomain', value);
//   }
// }

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
