import 'package:adam_group/Helpers/snackbar.dart';
import 'package:flutter/material.dart';

mixin DataCheckerHelper on SnackBarHelper {
  bool checkText(
    BuildContext context, {
    required String text,
    required String message,
  }) {
    if (text.isEmpty) {
      showSnackBar(
        context,
        message: message,
        error: true,
      );
      return false;
    }
    return true;
  }

  bool checkTextMatch(
    BuildContext context, {
    required String text1,
    required String text2,
    required String message,
  }) {
    if (text1 == text2) {
      return true;
    } else {
      showSnackBar(
        context,
        message: message,
        error: true,
      );
      return false;
    }
  }
}
