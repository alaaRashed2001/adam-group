import 'package:adam_group/API/Api_Controllers/auth_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Helpers/warning_dialog.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Inner_Screen/settings_screen.dart';
import 'package:adam_group/Screens/welcom_screen.dart';
import 'package:adam_group/Shared_Preferences/shared_prefrences.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WarningDialogHelper, NavigatorHelper {
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

    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return  Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.profile,
                      style: TextStyle(
                        color: color,
                        fontSize: MediaQuery.sizeOf(context).width * 0.06,
                        fontFamily: "cairoFonts",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  (MediaQuery.sizeOf(context).height * 0.05).height,
                 Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Expanded(
                             child: Text(
                               AppLocalizations.of(context)!.fullName,
                               style: TextStyle(
                                 color: color,
                                 fontSize: MediaQuery.sizeOf(context).width * 0.035,
                                 fontWeight: FontWeight.w300,
                                 fontFamily: "cairoFonts",
                               ),
                               textAlign: TextAlign.center,
                             ),
                           ),
                           (MediaQuery.sizeOf(context).width * 0.015).width,
                           Expanded(
                             flex: 3,
                             child: Container(
                               height: MediaQuery.sizeOf(context).height * 0.06,
                               width: double.infinity,
                               margin: EdgeInsets.symmetric(
                                 vertical: MediaQuery.sizeOf(context).height * 0.01,
                               ),
                               padding: EdgeInsets.symmetric(
                                 horizontal: MediaQuery.sizeOf(context).width * 0.04,
                                 vertical: MediaQuery.sizeOf(context).height * 0.015,
                               ),
                               decoration: BoxDecoration(
                                 color: Colors.transparent,
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(color: AppColor.borderColor),
                               ),
                               child: Text(
                                 auth.userModel?.name ?? '',
                                 style: TextStyle(
                                   color: color,
                                   fontSize: MediaQuery.sizeOf(context).width * 0.035,
                                   fontWeight: FontWeight.w300,
                                   fontFamily: "cairoFonts",
                                 ),
                               ),
                             ),
                           ),
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
                                 fontSize: MediaQuery.sizeOf(context).width * 0.035,
                                 fontWeight: FontWeight.w300,
                                 fontFamily: "cairoFonts",
                               ),
                               textAlign: TextAlign.center,
                             ),
                           ),
                           (MediaQuery.sizeOf(context).width * 0.015).width,
                           Expanded(
                             flex: 3,
                             child: Container(
                               height: MediaQuery.sizeOf(context).height * 0.06,
                               width: double.infinity,
                               margin: EdgeInsets.symmetric(
                                 vertical: MediaQuery.sizeOf(context).height * 0.01,
                               ),
                               padding: EdgeInsets.symmetric(
                                 horizontal: MediaQuery.sizeOf(context).width * 0.04,
                                 vertical: MediaQuery.sizeOf(context).height * 0.015,
                               ),
                               decoration: BoxDecoration(
                                 color: Colors.transparent,
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(color: AppColor.borderColor),
                               ),
                               child: Text(
                                 auth.userModel?.phone ?? '',
                                 style: TextStyle(
                                   color: color,
                                   fontSize: MediaQuery.sizeOf(context).width * 0.035,
                                   fontWeight: FontWeight.w300,
                                   fontFamily: "cairoFonts",
                                 ),
                               ),
                             ),
                           ),
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
                                 fontSize: MediaQuery.sizeOf(context).width * 0.035,
                                 fontWeight: FontWeight.w300,
                                 fontFamily: "cairoFonts",
                               ),
                               textAlign: TextAlign.center,
                             ),
                           ),
                           (MediaQuery.sizeOf(context).width * 0.015).width,
                           Expanded(
                             flex: 3,
                             child: Container(
                               height: MediaQuery.sizeOf(context).height * 0.06,
                               width: double.infinity,
                               margin: EdgeInsets.symmetric(
                                 vertical: MediaQuery.sizeOf(context).height * 0.01,
                               ),
                               padding: EdgeInsets.symmetric(
                                 horizontal: MediaQuery.sizeOf(context).width * 0.04,
                                 vertical: MediaQuery.sizeOf(context).height * 0.015,
                               ),
                               decoration: BoxDecoration(
                                 color: Colors.transparent,
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(color: AppColor.borderColor),
                               ),
                               child: Text(
                                 auth.userModel?.address ?? '',
                                 style: TextStyle(
                                   color: color,
                                   fontSize: MediaQuery.sizeOf(context).width * 0.035,
                                   fontWeight: FontWeight.w300,
                                   fontFamily: "cairoFonts",
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                  (MediaQuery.sizeOf(context).height * 0.05).height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GradientButton(
                        onPressed: () {
                          warningDialog(
                            title: AppLocalizations.of(context)!.logout,
                            subtitle: AppLocalizations.of(context)!.subTitleLogOut,
                            onPressed: () async => await _logout(),
                            context: context,
                          );
                        },
                        text: AppLocalizations.of(context)!.logout,
                        horizontalPadding: MediaQuery.sizeOf(context).width * 0.04,
                      ),
                      GradientButton(
                        onPressed: () {
                          jump(context, screen: const SettingsScreen());
                        },
                        text: AppLocalizations.of(context)!.settings,
                        horizontalPadding: MediaQuery.sizeOf(context).width * 0.05,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _logout() async {
    /// Function LogOut
    /// 1) Logout using API
    /// 2) Logout using SP
    /// 3) Control Navigation
    try {
      await AuthApiController().logout();
    } catch (e) {
      ///
    }
    await SharedPreferencesController().removeToken();
    Navigator.pop(context);
    await jump(context, screen: const WelcomeScreen(), replace: true);
  }
}
