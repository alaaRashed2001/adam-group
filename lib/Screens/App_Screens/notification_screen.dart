import 'package:flutter/material.dart';

import '../../Consts/app_color.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإشعارات',
          style: TextStyle(
            color: AppColor.primaryColor,
            fontFamily: "cairoFonts",
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // عدد الإشعارات
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColor.borderColor),
              ),
              elevation: 2,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColor.startColor, AppColor.endColor],
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: AppColor.lightScaffoldColor,
                  ),
                ),
                title: Text(
                  'عنوان الإشعار ${index + 1}',
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontFamily: "cairoFonts",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'تفاصيل الإشعار ${index + 1} هنا.',
                  style: const TextStyle(
                    color: AppColor.secondaryColor,
                    fontFamily: "cairoFonts",
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.secondaryColor,
                  size: 16,
                ),
                onTap: () {
                  // إضافة الأكشن عند الضغط على الإشعار
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
