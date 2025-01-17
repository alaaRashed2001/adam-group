import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Helpers/warning_dialog.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Inner_Screen/settings_screen.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WarningDialogHelper {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.profile,
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
                  child: CircleAvatar(
                    backgroundColor: AppColor.borderColor,
                    radius: 90.w,
                    backgroundImage:
                        const AssetImage('assets/images/avatar.png'),
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
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: Text(
                              "محمد احمد",
                              style: TextStyle(
                                color: color,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: "cairoFonts",
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          )),
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
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: Text(
                              "0502002689",
                              style: TextStyle(
                                color: color,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: "cairoFonts",
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          )),
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
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: Text(
                              "Nablus",
                              style: TextStyle(
                                color: color,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: "cairoFonts",
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 36.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () {
                      warningDialog(
                          title: AppLocalizations.of(context)!.logout,
                          subtitle:
                              AppLocalizations.of(context)!.subTitleLogOut,
                          onPressed: () {
                            /// Function LogOut
                          },
                          context: context);
                    },
                    text: AppLocalizations.of(context)!.logout,
                    horizontalPadding: 16.w,
                  ),
                  GradientButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                    },
                    text: AppLocalizations.of(context)!.settings,
                    horizontalPadding: 24,
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
