import 'package:flutter/material.dart';

import 'app_color.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColor.darkScaffoldColor
          : AppColor.lightScaffoldColor,
      // cardColor: isDarkTheme
      //     ? const Color.fromARGB(255, 13, 6, 37)
      //     : AppColor.lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme
            ? AppColor.darkScaffoldColor
            : AppColor.lightScaffoldColor,
        elevation: 0, // لجعل الـ AppBar بدون ظل
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

