import 'package:adam_group/API/Api_Controllers/auth_api_controller.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/data_checker_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Widgets/custom_text_field.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen>
    with SnackBarHelper, DataCheckerHelper {
  late final TextEditingController mobileEditingController;

  @override
  void initState() {
    mobileEditingController = TextEditingController();
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
                  AppLocalizations.of(context)!.changePhone,
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
                AppLocalizations.of(context)!.newMobile,
                style: TextStyle(
                  color: color,
                  fontSize: MediaQuery.sizeOf(context).width * 0.045,
                  fontFamily: "cairoFonts",
                ),
                textAlign: TextAlign.center,
              ),
              CustomTextInputField(
                controller: mobileEditingController,
                hint: "",
              ),
              (MediaQuery.sizeOf(context).height * 0.09).height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () async {
                      await performChangeMobileNumber();
                    },
                    text: AppLocalizations.of(context)!.save,
                    horizontalPadding: MediaQuery.sizeOf(context).width * 0.15,
                  ),
                  GradientButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

  Future<void> performChangeMobileNumber() async {
    if (_checkData()) {
      await changeMobileNumber();
    }
  }

  Future<void> changeMobileNumber() async {
    {
      setState(() {
        isLoading = true;
      });

      try {
        bool status = await AuthApiController()
            .changeMobile(context, mobileEditingController.text);
        if (status) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        print(e.toString());
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  bool _checkData() => checkText(
        context,
        text: mobileEditingController.text,
        message: AppLocalizations.of(context)!.newPhoneNumberUpdate,
      );
}
