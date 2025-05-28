import 'package:adam_group/Models/user_model.dart';
import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferencesController _shared = SharedPreferencesController();

  late bool _isLoggedIn = _shared.isLoggedIn();

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String token) async {
    await _shared.setToken(token);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _shared.removeToken();
    _isLoggedIn = false;
    _userModel = null;
    await FirebaseMessaging.instance.deleteToken();
    notifyListeners();
  }

  /// User Model
  late UserModel? _userModel = _shared.userModel;

  UserModel? get userModel => _userModel;

  Future<void> saveUserModel(UserModel user) async {
    await _shared.saveUserModel(user);
    _userModel = user;
    await _shared.setFingerprintPhone(user.phone ?? '');
    await _shared.setFingerprintPassword(user.password?? '');
    notifyListeners();
  }
}
