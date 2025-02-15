import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  Future<bool> get canAuth async {
    /// Supported + Added
    bool supported = await _auth.isDeviceSupported();
    bool added = await _auth.canCheckBiometrics;

    return supported || added;
  }

  Future<bool> auth(BuildContext context) async {
    try {
      bool status = await _auth.authenticate(
        localizedReason: 'The app requires fingerprint.',
        options: AuthenticationOptions(
          useErrorDialogs: true,
          biometricOnly: true, // FaceId, FingerPrint, Pin, Password
          stickyAuth: true,
          sensitiveTransaction: false,
        ),
        authMessages: [
          AndroidAuthMessages(
            signInTitle: 'Access application',
            biometricHint: '',
            goToSettingsButton: 'Go to settings',
            cancelButton: 'Cancel',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel',
            goToSettingsButton: 'Go to settings',
          ),
        ],

      );
      return status;
    } catch (e) {
      return false;
    }
  }
}
