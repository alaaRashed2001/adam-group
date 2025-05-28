import 'package:adam_group/API/Api_Controllers/auth_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Helpers/warning_dialog.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Providers/lang_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Auth_Screens/change_password_screen.dart';
import 'package:adam_group/Screens/Auth_Screens/change_phone_number_screen.dart';
import 'package:adam_group/Screens/Inner_Screen/edit_profile_screen.dart';
import 'package:adam_group/Screens/Widgets/settings_grid.dart';
import 'package:adam_group/Screens/welcom_screen.dart';
import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
import 'package:adam_group/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WarningDialogHelper, NavigatorHelper {
  late bool _isFingerprintEnabled;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;
    final langProvider = Provider.of<LangProvider>(context);
    bool isArabic = langProvider.lang == 'ar';

    final List<Map<String, dynamic>> settings = [
      {
        'title': AppLocalizations.of(context)!.updateInfo,
        'image': Assets.settingsUpdateInfo,
        'action': (BuildContext context) {
          jump(context, screen: const EditProfileScreen());
        },
      },
      {
        'title': AppLocalizations.of(context)!.changePassword,
        'image': Assets.settingsChangePassword,
        'action': (BuildContext context) {
          jump(context, screen: const ChangePasswordScreen());
        },
      },
      {
        'title': AppLocalizations.of(context)!.changePhone,
        'image':Assets.settingsChangeMobileNumber,
        'action': (BuildContext context) {
          jump(context, screen: const ChangePhoneNumberScreen());
        },
      },
      {
        'title': AppLocalizations.of(context)!.privacyPolicy,
        'image': Assets.settingsPrivacyPolicy,
        'action': (BuildContext context) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.privacyPolicy,
                style: const TextStyle(
                  fontFamily: "cairoFonts",
                ),
              ),
              content: Text(
                AppLocalizations.of(context)!.subTitlePolicy,
                maxLines: 15,
                style: TextStyle(
                  color: color,
                  fontFamily: "cairoFonts",
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: const TextStyle(color: AppColor.primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
      },
      {
        'title': AppLocalizations.of(context)!.contactUs,
        'image': Assets.settingsContactUs,
        'action': (BuildContext context) {
          _showCustomBottomSheet(context);
        },
      },
      {
        'title': AppLocalizations.of(context)!.deleteAccount,
        'image': Assets.settingsDeleteAccount,
        'action': (BuildContext context) {
          warningDialog(
              title: AppLocalizations.of(context)!.deleteAccount,
              subtitle: AppLocalizations.of(context)!.subTitleDeleteAccount,
              onPressed: () async {
                try {
                  AuthProvider auth =
                      Provider.of<AuthProvider>(context, listen: false);
                  await AuthApiController()
                      .deleteAccount(auth.userModel?.id.toString() ?? '');
                } catch (e) {
                  ///
                }
                await SharedPreferencesController().removeToken();
                Navigator.pop(context);
                await jump(context,
                    screen: const WelcomeScreen(), replace: true);
              },
              context: context);
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.settings,
                  style: TextStyle(
                    color: color,
                    fontSize: 36.sp,
                    fontFamily: "cairoFonts",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              (MediaQuery.sizeOf(context).height * 0.03).height,
              SettingsGrid(settings: settings),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.lightScaffoldColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04,
            vertical: MediaQuery.sizeOf(context).height * 0.02,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.startColor, AppColor.endColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.1,
                height: MediaQuery.sizeOf(context).height * 0.01,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.chooseAction,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "cairoFonts",
                  color: AppColor.borderColor,
                ),
              ),
              (MediaQuery.sizeOf(context).height * 0.03).height,
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  child: Icon(Icons.phone, color: Colors.white),
                ),
                title: Text(
                  AppLocalizations.of(context)!.callPhoneNumber,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.borderColor,
                    fontFamily: "cairoFonts",
                  ),
                ),
                onTap: () {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: '+972 566008007',
                  );
                  launchUrl(phoneUri);
                  Navigator.pop(context);
                },
              ),
              Divider(color: AppColor.borderColor.withOpacity(0.3)),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  child: Icon(Icons.add_ic_call_outlined, color: Colors.white),
                ),
                title: Text(
                  AppLocalizations.of(context)!.whatsapp,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.borderColor,
                    fontFamily: "cairoFonts",
                  ),
                ),
                onTap: () async {
                  final Uri whatsappUri =
                      Uri.parse('https://wa.me/972566008007');
                  if (await canLaunchUrl(whatsappUri)) {
                    await launchUrl(
                      whatsappUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    print('لا يمكن فتح الواتساب');
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
