import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangProvider extends ChangeNotifier {
  String _lang = 'en'; // اللغة الافتراضية
  late SharedPreferences _prefs;

  LangProvider() {
    _initializePreferences();
  }

  String get lang => _lang;

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _lang = _prefs.getString('lang') ??
        'en'; // قراءة اللغة المحفوظة أو استخدام الافتراضي
    notifyListeners(); // تحديث الـ UI إذا لزم
  }

  Future<void> changeLanguage() async {
    _lang = (_lang == 'ar') ? 'en' : 'ar';
    await _prefs.setString('lang', _lang); // تحديث القيمة في SharedPreferences
    notifyListeners(); // إعلام الـ UI بتغيير اللغة
  }
}
