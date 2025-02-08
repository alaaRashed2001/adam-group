import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.statement,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: screenWidth * 0.06,
                    fontFamily: "cairoFonts",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
             SizedBox(height: screenHeight * 0.03),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.08,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.borderColor),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Image.network(
                      "https://media.gettyimages.com/id/1349093190/photo/container-ship-beneath-bridge.jpg?s=612x612&w=0&k=20&c=dGETLAo0CjIvl7rTX6XE_V-snNEdWKdH0WdoUnd6_tc=",
                      height: screenHeight * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
                    onPressed: () {
                      /// كود التنزيل هنا
                    },
                    text: AppLocalizations.of(context)!.download,
                  ),
                  GradientButton(
                    onPressed: () {
                      /// كود المشاركة هنا
                    },
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
