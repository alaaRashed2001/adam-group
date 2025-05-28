import 'package:adam_group/API/Api_Controllers/auth_api_controller.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/data_checker_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Widgets/custom_text_field.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with SnackBarHelper, DataCheckerHelper {
  late final TextEditingController currentPasswordEditingController;
  late final TextEditingController newPasswordEditingController;
  late final TextEditingController confirmPasswordEditingController;

  @override
  void initState() {
    currentPasswordEditingController = TextEditingController();
    newPasswordEditingController = TextEditingController();
    confirmPasswordEditingController = TextEditingController();
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
                  AppLocalizations.of(context)!.changePassword,
                  style: TextStyle(
                    color: color,
                    fontSize: MediaQuery.sizeOf(context).width * 0.06,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              (MediaQuery.sizeOf(context).height * 0.05).height,
              Text(
                AppLocalizations.of(context)!.currentPassword,
                style: TextStyle(
                  color: color,
                  fontSize: MediaQuery.sizeOf(context).width * 0.045,
                  fontFamily: "cairoFonts",
                ),
                textAlign: TextAlign.center,
              ),
              CustomTextInputField(
                controller: currentPasswordEditingController,
                hint: AppLocalizations.of(context)!.currentPassword,
              ),
              (MediaQuery.sizeOf(context).height * 0.04).height,
              Text(
                AppLocalizations.of(context)!.newPassword,
                style: TextStyle(
                  color: color,
                  fontSize: MediaQuery.sizeOf(context).width * 0.045,
                  fontFamily: "cairoFonts",
                ),
                textAlign: TextAlign.center,
              ),
              CustomTextInputField(
                controller: newPasswordEditingController,
                hint: AppLocalizations.of(context)!.newPassword,
                obscure: true,
              ),
              ( MediaQuery.sizeOf(context).height * 0.04).height,
              Text(
                AppLocalizations.of(context)!.confirmPassword,
                style: TextStyle(
                  color: color,
                  fontSize: MediaQuery.sizeOf(context).width * 0.045,
                  fontFamily: "cairoFonts",
                ),
                textAlign: TextAlign.center,
              ),
              CustomTextInputField(
                controller: confirmPasswordEditingController,
                hint: AppLocalizations.of(context)!.confirmPassword,
                obscure: true,
              ),
              (MediaQuery.sizeOf(context).height * 0.05).height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () async => await _performChangePassword(),
                    text: AppLocalizations.of(context)!.save,
                    horizontalPadding: MediaQuery.sizeOf(context).width * 0.15,
                  ),
                  GradientButton(
                    onPressed: () => Navigator.pop(context),
                    text: AppLocalizations.of(context)!.cancel,
                    horizontalPadding: MediaQuery.sizeOf(context).width * 0.15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performChangePassword() async {
    if (_checkData()) {
      await _changePassword();
    }
  }

  Future<void> _changePassword() async {
    setState(() {
      isLoading = true;
    });
    try {

      var result = await AuthApiController().changePassword(
        context,
        currentPasswordEditingController.text,
        newPasswordEditingController.text,
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
        text: currentPasswordEditingController.text,
        message:  AppLocalizations.of(context)!.currentPasswordUpdate,
      ) &&
      checkText(
        context,
        text: newPasswordEditingController.text,
        message: AppLocalizations.of(context)!.newPasswordToSave,
      ) &&
      checkText(
        context,
        text: confirmPasswordEditingController.text,
        message: AppLocalizations.of(context)!.confirmPasswordMatches,
      ) &&
      checkTextMatch(
        context,
        text1: newPasswordEditingController.text,
        text2: confirmPasswordEditingController.text,
        message: AppLocalizations.of(context)!.newPasswordMatchConfirmedPassword,
      );
}
