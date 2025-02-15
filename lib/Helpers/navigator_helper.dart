import 'package:flutter/material.dart';

mixin NavigatorHelper {
  Future<void> jump(
    BuildContext context, {
    required Widget screen,
    bool replace = false,
  }) async {
    if (replace) {
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => screen));
    } else {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => screen));
    }
  }
}
