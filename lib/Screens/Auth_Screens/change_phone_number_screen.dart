import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Widgets/custom_text_field.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  late final TextEditingController mobileEditingController;

  @override
  void initState() {
    mobileEditingController = TextEditingController();
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.changePhone,
                  style: TextStyle(
                    color: color,
                    fontSize: 24.sp,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45.h,
              ),

              /// New Mobile Number
              Text(
                AppLocalizations.of(context)!.newMobile,
                style: TextStyle(
                  color: color,
                  fontSize: 16.sp,
                  fontFamily: "cairoFonts",
                ),
                textAlign: TextAlign.center,
              ),
              CustomTextInputField(
                controller: mobileEditingController,
                hint: "",
              ),
              SizedBox(
                height: 30.h,
              ),

              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.save,
                    horizontalPadding: 54,
                  ),
                  GradientButton(
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.cancel,
                    horizontalPadding: 54,
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
