import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

//class PreferencesHelper {
class Preferences {

  Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  Future setInt(String key, int value) async {
    final p = await prefs;
    return p.setInt(key, value);
  }

  Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  Future setDouble(String key, double value) async {
    final p = await prefs;
    return p.setDouble(key, value);
  }

  containsKey(String key) async {
    final p = await prefs;
    return p.containsKey(key);
  }

  clear() async {
    final p = await prefs;
    return p.clear();
  }

  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

/*
class Const {
  static const String TUTORIAL_STRING = 'TUTORIAL_STRING';

  // Default preferences
  static const String AUTHENTICATED = 'AUTHENTICATED';
  static const String PASSCODE = 'PASSCODE';
  static const String FINGERPRINT_ENABLED = 'FINGERPRINT_ENABLED';
}
*/
/*
class Prefs {
  static Future<String> get tutorialString => PreferencesHelper.getString(Const.TUTORIAL_STRING);

  static Future setTutorialString(String value) => PreferencesHelper.setString(Const.TUTORIAL_STRING, value);

  static Future<bool> get authenticated => PreferencesHelper.getBool(Const.AUTHENTICATED);

  static Future setAuthenticated(bool value) => PreferencesHelper.setBool(Const.AUTHENTICATED, value);

  static Future<String> get passcode => PreferencesHelper.getString(Const.PASSCODE);

  static Future setPasscode(String value) => PreferencesHelper.setString(Const.PASSCODE, value);

  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }
}
*/
