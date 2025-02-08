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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04), // الهوامش الديناميكية
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
                height: MediaQuery.sizeOf(context).height * 0.03, // المسافة بين العنوان والعناصر
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
                        radius: MediaQuery.sizeOf(context).width * 0.2,
                        backgroundImage: const AssetImage('assets/images/avatar.png'),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            // فعل تحميل الصورة
                          },
                          child: Image.asset(
                            'assets/images/upload_avatar.png',
                            width: MediaQuery.sizeOf(context).width * 0.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
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
                        width: MediaQuery.sizeOf(context).width * 0.02,
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
                        width: MediaQuery.sizeOf(context).width * 0.02,
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
                        width: MediaQuery.sizeOf(context).width * 0.02,
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
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              Center(
                child: GradientButton(
                  onPressed: () {
                    /// Update Info
                  },
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
}
