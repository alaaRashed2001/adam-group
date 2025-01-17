import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.searchShipment,
                    style: TextStyle(
                      color: color,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "cairoFonts",
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    height: 2,
                    margin: const EdgeInsets.only(left: 160),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.startColor,
                          AppColor.endColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.shipmentNumber,
                  suffixIcon: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Image.asset(
                      "assets/images/bottom/search.png",
                      width: 8,
                    ),
                  ),
                  border: buildOutlineInputBorder(),
                  focusedBorder: buildOutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.0.h),
                ),
                onChanged: (value) {
                  /// The action when typing text in the field
                  print('Search query: $value');
                },
              ),
              SizedBox(
                height: 84.h,
              ),
              Center(
                child: Image.asset("assets/images/noData.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        color: AppColor.borderColor,
        width: 1.0,
      ),
    );
  }
}
