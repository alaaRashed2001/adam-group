import 'package:adam_group/Consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsGridItem extends StatelessWidget {
  // final IconData icon;
  final String image;
  final String title;
  final VoidCallback onTap;

  const SettingsGridItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.darkScaffoldColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColor.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: MediaQuery.sizeOf(context).width * 0.18,
              height: MediaQuery.sizeOf(context).height * 0.12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: "cairoFonts",
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
