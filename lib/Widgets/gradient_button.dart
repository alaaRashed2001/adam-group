import 'package:adam_group/Consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double horizontalPadding;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 34,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 6.0.h,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColor.startColor,
              AppColor.endColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0.sp,
            fontFamily: "cairoFonts",
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
