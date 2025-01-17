import 'package:adam_group/Consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    this.isLoading = false,
    required this.onPressed,
  });

  final String buttonName;
  final bool isLoading;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColor.darkScaffoldColor,
          border: Border.all(color: Colors.black54)),
      child: TextButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                buttonName,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 20.sp,
                  fontFamily: "cairoFonts",
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
