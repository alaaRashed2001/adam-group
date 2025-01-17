import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
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
                  AppLocalizations.of(context)!.statement,
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

              ///  CachedNetworkImage(

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 74.h),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: const Color(0xFF6A6060)),
              //     borderRadius: BorderRadius.circular(20.r),
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(24),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color(0xFF6A6060)),
              //         borderRadius: BorderRadius.circular(20.r),
              //       ),
              //       child: CachedNetworkImage(
              //         imageUrl:
              //             "https://media.gettyimages.com/id/1349093190/photo/container-ship-beneath-bridge.jpg?s=612x612&w=0&k=20&c=dGETLAo0CjIvl7rTX6XE_V-snNEdWKdH0WdoUnd6_tc=",
              //         height: 320,
              //         fit: BoxFit.cover,
              //         placeholder: (context, url) => const Center(
              //           child:
              //               CircularProgressIndicator(), // يظهر أثناء تحميل الصورة
              //         ),
              //         errorWidget: (context, url, error) => const Center(
              //           child: Icon(Icons.error,
              //               color: Colors.red), // يظهر في حال حدوث خطأ
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 74.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.borderColor),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Image.network(
                      //"https://media.gettyimages.com/id/1499124310/photo/aerial-view-of-container-ship-in-sea.jpg?s=1024x1024&w=gi&k=20&c=_jftUPLknD0zat_Rmsz_el3eAOtxoZTpZkRXWO5yJQk=",
                      "https://media.gettyimages.com/id/1349093190/photo/container-ship-beneath-bridge.jpg?s=612x612&w=0&k=20&c=dGETLAo0CjIvl7rTX6XE_V-snNEdWKdH0WdoUnd6_tc=",
                      //  width: double.infinity,
                      height: 320,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.download,
                  ),
                  GradientButton(
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.share,
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
