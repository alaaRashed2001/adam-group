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

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04),
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
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),


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
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),


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
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),

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
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.save,
                    horizontalPadding: MediaQuery.sizeOf(context).width * 0.15,
                  ),
                  GradientButton(
                    onPressed: () {},
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
}
