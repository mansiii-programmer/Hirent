import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  static Future<void> setJson(String key, Map<String, dynamic> json) async {
    await _prefs?.setString(key, jsonEncode(json));
  }

  static Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs?.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  static Future<void> saveToken(String token) async {
    await setString('auth_token', token);
  }

  static String? getToken() {
    return getString('auth_token');
  }

  static Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await setJson('user_profile', profile);
  }

  static Map<String, dynamic>? getUserProfile() {
    return getJson('user_profile');
  }

  static Future<void> saveUserTasks(List<String> tasks) async {
    await setStringList('user_tasks', tasks);
  }

  static List<String>? getUserTasks() {
    return getStringList('user_tasks');
  }

  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
