import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Auth_Screens/change_password_screen.dart';
import 'package:adam_group/Screens/bottom_navigat_bar.dart';
import 'package:adam_group/Widgets/custom_button.dart';
import 'package:adam_group/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
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
              height: MediaQuery.sizeOf(context).height * 0.06,
            ),

            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.sizeOf(context).width * 0.7,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.05),
              child: CustomTextInputField(
                controller: mobileEditingController,
                hint: AppLocalizations.of(context)!.mobileNumber,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.05),
              child: CustomTextInputField(
                controller: passwordEditingController,
                obscure: true,
                hint: AppLocalizations.of(context)!.password,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04, vertical: MediaQuery.sizeOf(context).height * 0.02),
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
                    fontSize: MediaQuery.sizeOf(context).width * 0.04,
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
              height: MediaQuery.sizeOf(context).height * 0.02,
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
                            horizontal: MediaQuery.sizeOf(context).width * 0.05,
                            vertical: MediaQuery.sizeOf(context).height * 0.02),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/fingerprint.png",
                              height: MediaQuery.sizeOf(context).height * 0.12,
                              width: MediaQuery.sizeOf(context).width * 0.24,
                            ),
                            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.confirmFingerprint,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.sizeOf(context).width * 0.04,
                                fontFamily: "cairoFonts",
                              ),
                            ),
                            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
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
                  width: MediaQuery.sizeOf(context).width * 0.28,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
