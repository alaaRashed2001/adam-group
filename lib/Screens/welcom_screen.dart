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
          Expanded(
            child: Center(
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 62.h,
                  ),
                  // الشعار
                  Image.asset(
                    'assets/images/logo.png',
                    width: 380,
                  ),

                  // SizedBox(height: 16.h),
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
                  const SizedBox(height: 10),
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
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                themeProvider.isDarkTheme
                    ? "assets/images/copper_dark.png"
                    : "assets/images/copper_light.png",
                width: 330,
              )),
          Positioned(
              bottom: 10,
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
                        color: AppColor.primaryColor
                            .withOpacity(0.8), // اللون الذهبي مع شفافية خفيفة
                        spreadRadius: 2, // مدى انتشار الظل
                        blurRadius: 10, // مدى نعومة الظل
                        offset: const Offset(
                            0, 1), // الإزاحة الأفقية والعمودية للظل
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
              ))
        ],
      ),
    );
  }
}
