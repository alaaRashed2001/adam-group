import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  final SharedPreferencesController _sharedPreferencesController = SharedPreferencesController();

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadThemePreference();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _sharedPreferencesController.setTheme(_isDarkTheme);
    notifyListeners();
  }

  void _loadThemePreference() async {
    await _sharedPreferencesController.initSharedPreferences();
    _isDarkTheme = _sharedPreferencesController.getTheme;
    notifyListeners();
  }
}
//
// class ThemeProvider with ChangeNotifier {
//   bool _isDarkTheme = false;
//
//   bool get isDarkTheme => _isDarkTheme;
//
//   ThemeProvider() {
//     _loadThemePreference();
//   }
//
//   void toggleTheme() {
//     _isDarkTheme = !_isDarkTheme;
//     _saveThemePreference();
//     notifyListeners();
//   }
//
//   void _loadThemePreference() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
//     notifyListeners();
//   }
//
//   void _saveThemePreference() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkTheme', _isDarkTheme);
//   }
// }
