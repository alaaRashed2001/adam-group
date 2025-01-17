import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Auth_Screens/change_password_screen.dart';
import 'package:adam_group/Screens/bottom_navigat_bar.dart';
import 'package:adam_group/Widgets/custom_button.dart';
import 'package:adam_group/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController mobileEditingController;
  late final TextEditingController passwordEditingController;
  @override
  void initState() {
    mobileEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 52.h,
            ),
            // الشعار
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 350,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomTextInputField(
                controller: mobileEditingController,
                hint: AppLocalizations.of(context)!.mobileNumber,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomTextInputField(
                controller: passwordEditingController,
                obscure: true,
                hint: AppLocalizations.of(context)!.password,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.w),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen(),
                  ));
                },
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: TextStyle(
                    color: color,
                    fontSize: 14.sp,
                    fontFamily: "cairoFonts",
                  ),
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                /// Auth Log In
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BottomNavigateBar(),
                ));
              },
              buttonName: AppLocalizations.of(context)!.login,
            ),
            SizedBox(
              height: 16.h,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(46)),
                    ),
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/fingerprint.png",
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              AppLocalizations.of(context)!.confirmFingerprint,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.h,
                                fontFamily: "cairoFonts",
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: TextStyle(color: color),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Image.asset(
                  "assets/images/fingerprint.png",
                  width: 112,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
