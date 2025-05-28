import 'dart:convert';

import 'package:adam_group/Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  static const String themeKey = 'theme';
  static const String langKey = 'lang';
  static const String loggedIn = 'loggedIn';
  static const String tokenKey = 'token';
  static const String userModelKey = 'user_model';
  static const String fcm = 'fcm';

  /// FP
  static const String fingerprintKey = 'fingerprint_enabled';
  static const String fpPhone = 'fingerprint_phone';
  static const String fpPassword = 'fingerprint_password';

  static final SharedPreferencesController _sharedPrefControllerObj =
      SharedPreferencesController._sharedPrefPrivateConstructor();

  SharedPreferencesController._sharedPrefPrivateConstructor();

  late SharedPreferences _sharedPrefLibObj;

  factory SharedPreferencesController() {
    return _sharedPrefControllerObj;
  }

  Future<void> initSharedPreferences() async {
    _sharedPrefLibObj = await SharedPreferences.getInstance();
  }

  /// Save Theme
  Future<void> setTheme(bool isDarkTheme) async {
    await _sharedPrefLibObj.setBool(themeKey, isDarkTheme);
  }

  bool get getTheme => _sharedPrefLibObj.getBool(themeKey) ?? false;

  /// Save Language
  Future<void> setLanguage(String language) async {
    await _sharedPrefLibObj.setString(langKey, language);
  }

  String get getLanguage => _sharedPrefLibObj.getString(langKey) ?? 'ar';

  /// Save Token
  Future<void> setToken(String token) async {
    await _sharedPrefLibObj.setBool(loggedIn, true);
    await _sharedPrefLibObj.setString(tokenKey, 'Bearer $token');
  }

  String? get getToken => _sharedPrefLibObj.getString(tokenKey);

  /// Remove Token
  Future<void> removeToken() async {
    await _sharedPrefLibObj.remove(tokenKey);
    await _sharedPrefLibObj.remove(userModelKey);
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _sharedPrefLibObj.containsKey(tokenKey) &&
        _sharedPrefLibObj.getBool(loggedIn) == true;
  }

  /// User Model
  Future<void> saveUserModel(UserModel user) async {
    await _sharedPrefLibObj.setString(userModelKey, jsonEncode(user.toJson()));
  }

  UserModel? get userModel {
    var data = _sharedPrefLibObj.getString(userModelKey);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  /// Save FCM Token
  Future<void> setFCM(String token) async {
    await _sharedPrefLibObj.setString(fcm, token);
  }

  String? get getFCM => _sharedPrefLibObj.getString(fcm);

  /// Save Fingerprint Data

  Future<void> setFingerprintPhone(String phone) async {
    await _sharedPrefLibObj.setString(fpPhone, phone);
  }

  String? get getFingerprintPhone => _sharedPrefLibObj.getString(fpPhone);

  Future<void> setFingerprintPassword(String password) async {
    await _sharedPrefLibObj.setString(fpPassword, password);
  }

  String? get getFingerprintPassword => _sharedPrefLibObj.getString(fpPassword);

  Future<void> saveLastLoginPhone(String phone) async {
    await _sharedPrefLibObj.setString('lastLoginPhone', phone);
  }
  String? get lastLoginPhone => _sharedPrefLibObj.getString('lastLoginPhone');
}
