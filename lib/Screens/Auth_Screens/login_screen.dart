import 'dart:developer';

import 'package:adam_group/API/Api_Controllers/auth_api_controller.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/data_checker_helper.dart';
import 'package:adam_group/Helpers/local_auth.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Auth_Screens/change_password_screen.dart';
import 'package:adam_group/Screens/bottom_navigat_bar.dart';
import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
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

class _LoginScreenState extends State<LoginScreen>
    with SnackBarHelper, NavigatorHelper, DataCheckerHelper {
  late final TextEditingController mobileEditingController;
  late final TextEditingController passwordEditingController;

  @override
  void initState() {
    mobileEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
    _init;
  }

  bool isLoading = false;
  bool _canUseFingerPrint = false;

  Future<void> get _init async {
    bool status = await LocalAuth().canAuth;
    setState(() => _canUseFingerPrint = status);
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
            (MediaQuery.sizeOf(context).height * 0.06).height,
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.sizeOf(context).width * 0.7,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.05),
              child: CustomTextInputField(
                controller: mobileEditingController,
                hint: AppLocalizations.of(context)!.mobileNumber,
              ),
            ),
            ( MediaQuery.sizeOf(context).height * 0.02).height,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.05),
              child: CustomTextInputField(
                controller: passwordEditingController,
                obscure: true,
                hint: AppLocalizations.of(context)!.password,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.04,
                  vertical: MediaQuery.sizeOf(context).height * 0.02),
              child: InkWell(
                onTap: () {
                jump(context, screen: const ChangePasswordScreen());

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
              onPressed: () async {
                await performLogin();
              },
              buttonName: AppLocalizations.of(context)!.login,
            ),
            (MediaQuery.sizeOf(context).height * 0.02).height,
            if (_canUseFingerPrint) ...[
              Center(
                child: InkWell(
                  onTap: () async {
                    var status = await LocalAuth().auth(context);
                    log(status.toString());
                    jump(
                      context,
                      screen: const BottomNavigateBar(),
                      replace: true,
                    );
                    return;
                    // showModalBottomSheet(
                    //   context: context,
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius:
                    //         BorderRadius.vertical(top: Radius.circular(46)),
                    //   ),
                    //   isScrollControlled: true,
                    //   builder: (context) {
                    //     return Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal:
                    //               MediaQuery.sizeOf(context).width * 0.05,
                    //           vertical:
                    //               MediaQuery.sizeOf(context).height * 0.02),
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Image.asset(
                    //             "assets/images/fingerprint.png",
                    //             height:
                    //                 MediaQuery.sizeOf(context).height * 0.12,
                    //             width: MediaQuery.sizeOf(context).width * 0.24,
                    //           ),
                    //           SizedBox(
                    //               height:
                    //                   MediaQuery.sizeOf(context).height * 0.02),
                    //           Text(
                    //             AppLocalizations.of(context)!
                    //                 .confirmFingerprint,
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               fontSize:
                    //                   MediaQuery.sizeOf(context).width * 0.04,
                    //               fontFamily: "cairoFonts",
                    //             ),
                    //           ),
                    //           SizedBox(
                    //               height:
                    //                   MediaQuery.sizeOf(context).height * 0.02),
                    //           Align(
                    //             alignment: Alignment.centerLeft,
                    //             child: ElevatedButton(
                    //               onPressed: () {
                    //                 Navigator.pop(context);
                    //               },
                    //               child: Text(
                    //                 AppLocalizations.of(context)!.cancel,
                    //                 style: TextStyle(color: color),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  child: Image.asset(
                    "assets/images/fingerprint.png",
                    width: MediaQuery.sizeOf(context).width * 0.28,
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (_checkData()) {
      await login();
    }
  }

  Future<void> login() async {
    {
      setState(() {
        isLoading = true;
      });

      try {
        AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
        final loginResponse = await AuthApiController().login(
          context,
          mobileEditingController.text,
          passwordEditingController.text,
        );
        if (loginResponse != null) {
          print('Login successful: ${loginResponse.user!.name}');
          var token = loginResponse.accessToken ?? '';
          await auth.login(token);
          await auth.saveUserModel(loginResponse.user!);
          await AuthApiController().saveFcm(context, SharedPreferencesController().getFCM);

          jump(
            context,
            screen: const BottomNavigateBar(),
            replace: true,
          );
        } else {
          print('Login failed');
        }
      } catch (e) {
        print(e.toString());
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  bool _checkData() =>
      checkText(
        context,
        text: mobileEditingController.text,
        message: AppLocalizations.of(context)!.phoneNumberCannotEmpty,
      ) &&
          checkText(
            context,
            text: passwordEditingController.text,
            message:AppLocalizations.of(context)!.passwordCannotEmpty ,
          ) ;
}
