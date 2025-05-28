import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Providers/lang_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/App_Screens/places_screen.dart';
import 'package:adam_group/generated/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with NavigatorHelper {
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
                (MediaQuery.of(context).size.height * 0.1).height,
                Image.asset(
                  Assets.imagesLogo,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                Text(
                  AppLocalizations.of(context)!.aWorldOfInnovationAndCreativity,
                  style: TextStyle(
                    color: color,
                    fontSize: 18.sp,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
                10.height,
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
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Image.asset(
              themeProvider.isDarkTheme
                  ? "assets/images/copper_dark.png"
                  : "assets/images/copper_light.png",
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: 10,
            child: InkWell(
              onTap: () {
                jump(context, screen: const PlacesScreen(), replace: true);
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
