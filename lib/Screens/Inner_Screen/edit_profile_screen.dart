import 'package:adam_group/API/Api_Controllers/auth_api_controller.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/data_checker_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Widgets/custom_text_field.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SnackBarHelper, DataCheckerHelper {
  late final TextEditingController nameEditingController;

  late final TextEditingController emailEditingController;

  late final TextEditingController passwordEditingController;
  late final TextEditingController phoneEditingController;

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    nameEditingController =
        TextEditingController(text: _auth.userModel?.name ?? '');
    emailEditingController =
        TextEditingController(text: _auth.userModel?.email ?? '');
    passwordEditingController =
        TextEditingController(text: _auth.userModel?.password ?? '');
    phoneEditingController =
        TextEditingController(text: _auth.userModel?.phone ?? '');

    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.updateInfo,
                  style: TextStyle(
                    color: color,
                    fontSize: 24.sp,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              (MediaQuery.sizeOf(context).height * 0.05).height,
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.fullName,
                          style: TextStyle(
                            color: color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            fontFamily: "cairoFonts",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      (MediaQuery.sizeOf(context).width * 0.02).width,
                      Expanded(
                        flex: 3,
                        child: CustomTextInputField(
                            hint: "", controller: nameEditingController),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.email,
                          style: TextStyle(
                            color: color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            fontFamily: "cairoFonts",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      (MediaQuery.sizeOf(context).width * 0.02).width,
                      Expanded(
                        flex: 3,
                        child: CustomTextInputField(
                            hint: "", controller: emailEditingController),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.password,
                          style: TextStyle(
                            color: color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            fontFamily: "cairoFonts",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      (MediaQuery.sizeOf(context).width * 0.02).width,
                      Expanded(
                        flex: 3,
                        child: CustomTextInputField(
                            hint: "", controller: passwordEditingController),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.mobileNumber,
                          style: TextStyle(
                            color: color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            fontFamily: "cairoFonts",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      (MediaQuery.sizeOf(context).width * 0.02).width,
                      Expanded(
                        flex: 3,
                        child: CustomTextInputField(
                            hint: "", controller: phoneEditingController),
                      )
                    ],
                  ),
                ],
              ),
              (MediaQuery.sizeOf(context).height * 0.05).height,
              Center(
                child: GradientButton(
                  onPressed: () async => await _performUpdateUserInfo(),
                  text: AppLocalizations.of(context)!.save,
                  horizontalPadding: MediaQuery.sizeOf(context).width * 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performUpdateUserInfo() async {
    if (_checkData()) {
      await _updateUserInfo();
    }
  }

  Future<void> _updateUserInfo() async {
    setState(() {
      isLoading = true;
    });
    try {
      var result = await AuthApiController().updateUserInfo(
        context,
        nameEditingController.text,
        emailEditingController.text,
        passwordEditingController.text,
        phoneEditingController.text,

        //  addressEditingController.text,
      );

      if (result) {
        Navigator.pop(context);
      }
    } catch (e) {
      ///
    }
    setState(() {
      isLoading = false;
    });
  }

  bool _checkData() =>
      checkText(
        context,
        text: nameEditingController.text,
        message: AppLocalizations.of(context)!.newNameUpdate,
      ) &&
      checkText(
        context,
        text: emailEditingController.text,
        message: AppLocalizations.of(context)!.email,
      ) &&
      checkText(
        context,
        text: passwordEditingController.text,
        message: AppLocalizations.of(context)!.newPassword,
      ) &&
      checkText(
        context,
        text: phoneEditingController.text,
        message: AppLocalizations.of(context)!.newPhoneNumberUpdate,
      );
}
