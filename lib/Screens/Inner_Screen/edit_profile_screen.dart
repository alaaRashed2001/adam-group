import 'package:adam_group/Consts/app_color.dart';
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

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameEditingController;

  late final TextEditingController phoneEditingController;

  late final TextEditingController addressEditingController;

  @override
  void initState() {
    nameEditingController = TextEditingController();
    phoneEditingController = TextEditingController();
    addressEditingController = TextEditingController();
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
                  AppLocalizations.of(context)!.updateInfo,
                  style: TextStyle(
                    color: color,
                    fontSize: 24.sp,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.grey,
                  ),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.borderColor,
                        radius: 95.w,
                        backgroundImage:
                            const AssetImage('assets/images/avatar.png'),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            ///
                          },
                          child: Image.asset(
                            'assets/images/upload_avatar.png',
                            width: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
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
                      SizedBox(
                        width: 6.w,
                      ),
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
                      SizedBox(
                        width: 6.w,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomTextInputField(
                            hint: "", controller: phoneEditingController),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.address,
                          style: TextStyle(
                            color: color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            fontFamily: "cairoFonts",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomTextInputField(
                            hint: "", controller: addressEditingController),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 36.h,
              ),
              Center(
                child: GradientButton(
                  onPressed: () {
                    /// Update Info
                  },
                  text: AppLocalizations.of(context)!.save,
                  horizontalPadding: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
