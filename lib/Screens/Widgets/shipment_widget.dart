import 'package:adam_group/Consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShipmentWidget extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final bool isFull;

  const ShipmentWidget({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.isFull,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
              color:
                  isFull ? AppColor.darkScaffoldColor : AppColor.primaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.borderColor)),
          height: 88,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: isFull ? AppColor.primaryColor : AppColor.darkScaffoldColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.borderColor),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isFull
                      ? AppColor.darkScaffoldColor
                      : AppColor.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: "cairoFonts",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "cairoFonts",
                          color: isFull
                              ? AppColor.darkScaffoldColor
                              : AppColor.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "cairoFonts",
                          color: isFull
                              ? AppColor.darkScaffoldColor
                              : AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: isFull
                      ? AppColor.darkScaffoldColor
                      : AppColor.primaryColor,
                  child: Icon(
                    Icons.cloud_download,
                    size: 32,
                    color: isFull
                        ? AppColor.primaryColor
                        : AppColor.darkScaffoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
