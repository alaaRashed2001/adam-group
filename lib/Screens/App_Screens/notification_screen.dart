import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Consts/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.notification,
          style: const TextStyle(
            color: AppColor.primaryColor,
            fontFamily: "cairoFonts",
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primaryColor),
      ),
      body: notifications.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
              child: ListView.builder(
                itemCount: 10, // عدد الإشعارات
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.sizeOf(context).width * 0.03,
                      ),
                      side: const BorderSide(color: AppColor.borderColor),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.02),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColor.startColor, AppColor.endColor],
                          ),
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: AppColor.lightScaffoldColor,
                          size: MediaQuery.sizeOf(context).width * 0.06,
                        ),
                      ),
                      title: Text(
                        'عنوان الإشعار ${index + 1}',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontFamily: "cairoFonts",
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.sizeOf(context).width * 0.045,
                        ),
                      ),
                      subtitle: Text(
                        'تفاصيل الإشعار ${index + 1} هنا.',
                        style: TextStyle(
                          color: AppColor.secondaryColor,
                          fontFamily: "cairoFonts",
                          fontSize: MediaQuery.sizeOf(context).width * 0.035,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.secondaryColor,
                        size: MediaQuery.sizeOf(context).width * 0.04,
                      ),
                      onTap: () {
                        // إضافة الأكشن عند الضغط على الإشعار
                      },
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/notification.png',
                    width: 120.w,
                  ),
                  16.height,
                  Text(
                    AppLocalizations.of(context)!.notification,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      fontFamily: "cairoFonts",
                        fontSize: 24.sp,),
                  ),
                ],
              ),
            ),
    );
  }
}
