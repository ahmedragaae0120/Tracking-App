import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/core/constant.dart';

@singleton
@singleton
class CacheHelper {
  static SharedPreferences? _sharedPrefs;
  // we can save the keys over here
  // so that we can use them in the app like this 👇👇
  //  >>  static const String _tokenKey = 'auth_token';
  CacheHelper() {
    init();
    log("Constructor called shared prefs");
  }
  static void initForTest(SharedPreferences prefs) {
    _sharedPrefs = prefs;
  }

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    log("initialized shared prefs");
  }

  Future<void> _ensureInitialized() async {
    if (_sharedPrefs == null) {
      await init();
    }
  }

  // Future<bool> checkGuest() async {
  //   try {
  //     await _ensureInitialized();
  //     var guest = _sharedPrefs!.getBool(Constant.questCacheKey);
  //     if (guest == true) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     log("CacheHelper.isQuest() error: $e");
  //     return false;
  //   }
  // }

  static T? getRememberMe<T>() {
    if (_sharedPrefs == null) return null;
    return _sharedPrefs!.getBool(Constant.isRememberMe) as T?;
  }

  //========USAGE=========\\
  Future<bool> setData<T>(String key, T value) async {
    await _ensureInitialized();
    if (value is String) {
      return await _sharedPrefs!.setString(key, value);
    } else if (value is bool) {
      return await _sharedPrefs!.setBool(key, value);
    } else if (value is int) {
      return await _sharedPrefs!.setInt(key, value);
    } else if (value is double) {
      return await _sharedPrefs!.setDouble(key, value);
    } else if (value is List<String>) {
      return await _sharedPrefs!.setStringList(key, value);
    } else {
      throw Exception("Invalid type");
    }
  }

  //========USAGE=========\\
  Future<T> getData<T>(String key) async {
    await _ensureInitialized();

    if (T == String) {
      return (_sharedPrefs!.getString(key) as T?) ?? "" as T;
    } else if (T == bool) {
      return (_sharedPrefs!.getBool(key) as T?) ?? false as T;
    } else if (T == int) {
      return (_sharedPrefs!.getInt(key) as T?) ?? 0 as T;
    } else if (T == double) {
      return (_sharedPrefs!.getDouble(key) as T?) ?? 0.0 as T;
    } else if (T == List<String>) {
      return (_sharedPrefs!.getStringList(key) as T?) ?? [] as T;
    } else {
      throw Exception("Invalid type");
    }
  }

  Future<bool> removeData(String key) async {
    await _ensureInitialized();
    return await _sharedPrefs!.remove(key);
  }

  Future<bool> logout() async {
    await _ensureInitialized();
    return await _sharedPrefs!.clear();
  }
}
