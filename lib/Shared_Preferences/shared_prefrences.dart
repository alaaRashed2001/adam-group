import 'package:shared_preferences/shared_preferences.dart';

enum SpKeys {
  theme,
  lang,
  token,
}

class SharedPreferencesController {
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
    await _sharedPrefLibObj.setBool(SpKeys.theme.name, isDarkTheme);
  }

  bool get getTheme => _sharedPrefLibObj.getBool(SpKeys.theme.name) ?? false;

  /// Save Language
  Future<void> setLanguage(String language) async {
    await _sharedPrefLibObj.setString(SpKeys.lang.name, language);
  }

  String get getLanguage => _sharedPrefLibObj.getString(SpKeys.lang.name) ?? 'ar';

  /// Save Token
  Future<void> setToken(String token) async {
    await _sharedPrefLibObj.setString(SpKeys.token.name, token);
  }

  String? get getToken => _sharedPrefLibObj.getString(SpKeys.token.name);

  /// Remove Token
  Future<void> removeToken() async {
    await _sharedPrefLibObj.remove(SpKeys.token.name);
  }
}