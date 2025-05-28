import 'package:adam_group/API/Api_Controllers/notification_api_controller.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Models/notification_model.dart';
import 'package:adam_group/Screens/Widgets/notification_card_widget.dart';
import 'package:adam_group/generated/assets.dart';
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
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init;
  }

  bool _loading = true;

  Future<void> get _init async {
    await _getNotifications;
    setState(() {
      _loading = false;
    });
  }

  Future<void> get _getNotifications async {
    try {
      var data = await NotificationApiController().getNotifications();
      notifications = data;
    } catch (e) {
      ///
    }
  }

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
      body: !_loading
          ? notifications.isNotEmpty
              ? Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
                  child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) =>
                          NotificationCard(notification: notifications[index])


                      ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.imagesNotification,
                        width: 120.w,
                      ),
                      16.height,
                      Text(
                        AppLocalizations.of(context)!.notification,
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "cairoFonts",
                          fontSize: 24.sp,
                        ),
                      ),
                    ],
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            ),
    );
  }
}
