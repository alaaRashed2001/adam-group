// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LangProvider extends ChangeNotifier {
//   String _lang = 'ar'; // اللغة الافتراضية
//   late SharedPreferences _prefs;
//
//   LangProvider() {
//     _initializePreferences();
//   }
//
//   String get lang => _lang;
//
//   Future<void> _initializePreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     _lang = _prefs.getString('lang') ??
//         'ar'; // قراءة اللغة المحفوظة أو استخدام الافتراضي
//     notifyListeners(); // تحديث الـ UI إذا لزم
//   }
//
//   Future<void> changeLanguage() async {
//     _lang = (_lang == 'ar') ? 'en' : 'ar';
//     await _prefs.setString('lang', _lang); // تحديث القيمة في SharedPreferences
//     notifyListeners(); // إعلام الـ UI بتغيير اللغة
//   }
// }
import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class LangProvider with ChangeNotifier {
  String _lang = 'ar';
  final SharedPreferencesController _sharedPreferencesController = SharedPreferencesController();

  String get lang => _lang;

  LangProvider() {
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await _sharedPreferencesController.initSharedPreferences();
    _lang = _sharedPreferencesController.getLanguage;
    notifyListeners();
  }

  Future<void> changeLanguage() async {
    _lang = (_lang == 'ar') ? 'en' : 'ar';
    await _sharedPreferencesController.setLanguage(_lang);
    notifyListeners();
  }
}