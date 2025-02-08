import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/lang_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Auth_Screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1, // استخدام MediaQuery للحصول على ارتفاع مناسب
                ),
                // الشعار
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.8, // استخدام MediaQuery للحصول على عرض مناسب
                ),
                Text(
                  AppLocalizations.of(context)!
                      .aWorldOfInnovationAndCreativity,
                  style: TextStyle(
                    color: color,
                    fontSize: 18.sp,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.ourServicesAreFastAndReliable,
                  style: TextStyle(
                    color: color,
                    fontSize: 16.sp,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // جزء copper يغطي العرض الكامل ويكون ثابتًا في الأسفل
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom, // تحديد المسافة من الأسفل بناءً على الحواف
            left: 0,
            right: 0,
            child: Image.asset(
              themeProvider.isDarkTheme
                  ? "assets/images/copper_dark.png"
                  : "assets/images/copper_light.png",
              width: MediaQuery.of(context).size.width, // تأكد من أن الصورة تأخذ العرض الكامل
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05, // تحديد المسافة من الأسفل بناءً على الحجم
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundColor: themeProvider.isDarkTheme
                      ? AppColor.darkScaffoldColor
                      : AppColor.lightScaffoldColor,
                  child: Icon(
                    Provider.of<LangProvider>(context).lang == 'en'
                        ? Icons.arrow_forward
                        : Icons.arrow_back,
                    size: 32,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
