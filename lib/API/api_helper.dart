import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
import 'package:flutter/material.dart';

mixin ApiHelper on SnackBarHelper {
  final SharedPreferencesController _shared = SharedPreferencesController();

  Map<String, String> get apiHeaders {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept-Language': _shared.getLanguage,
    };

    if (_shared.isLoggedIn()) {
      headers['Authorization'] = _shared.getToken ?? '';
    }

    return headers;
  }


  void handleErrors(BuildContext context, Map<String, dynamic> response) {
    if (response.containsKey('errors')) {
      Map<String, dynamic> errors = response['errors'];
      if (errors.isNotEmpty) {
        String firstKey = errors.keys.first;
        List<dynamic> firstValue = errors[firstKey] ?? [];
        if (firstValue.isNotEmpty) {
          String message = firstValue.first.toString();
          showSnackBar(
            context,
            message: message,
            error: true,
          );
        }
      }
    } else if (response.containsKey('message')) {
      showSnackBar(
        context,
        message: response['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context,
        message: 'Something went wrong! Please try again.',
        error: true,
      );
    }
  }
}
