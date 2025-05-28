import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Helpers/converter_helper.dart';
import 'package:adam_group/Models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard>  with ConverterHelper{
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).width * 0.03),
        side: const BorderSide(color: AppColor.primaryColor),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).width * 0.03,
          horizontal: MediaQuery.sizeOf(context).width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              widget.notification.title ?? 'عنوان غير متوفر',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontFamily: "cairoFonts",
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.sizeOf(context).width * 0.045,
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).width * 0.015),


            Text(
              widget.notification.body ?? 'تفاصيل غير متوفرة',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontFamily: "cairoFonts",
                fontSize: MediaQuery.sizeOf(context).width * 0.035,
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).width * 0.02),


            Align(
              alignment: Alignment.centerRight,
              child: Text(
                convertStringDateToDateTime(widget.notification.createdAt ?? 'تاريخ غير متوفر')
                ,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.sizeOf(context).width * 0.032,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Card(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(
    //       MediaQuery.of(context).size.width * 0.03,
    //     ),
    //     side: const BorderSide(
    //       color: AppColor.primaryColor,
    //       //  color:notification.isRead == true ? Colors.grey : AppColor.primaryColor,
    //     ),
    //   ),
    //   elevation: 2,
    //   child: ListTile(
    //     leading: Container(
    //       padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.02),
    //       decoration: const BoxDecoration(
    //         shape: BoxShape.circle,
    //         gradient: LinearGradient(
    //           colors: [AppColor.startColor, AppColor.endColor],
    //         ),
    //       ),
    //       child: Icon(
    //         Icons.notifications,
    //         color: AppColor.lightScaffoldColor,
    //         size: MediaQuery.sizeOf(context).width * 0.06,
    //       ),
    //     ),
    //     title: Text(
    //       notification.title ?? 'عنوان غير متوفر',
    //       style: TextStyle(
    //         color: AppColor.primaryColor,
    //         fontFamily: "cairoFonts",
    //         fontWeight: FontWeight.bold,
    //         fontSize: MediaQuery.sizeOf(context).width * 0.045,
    //       ),
    //     ),
    //     subtitle: Text(
    //       notification.body ?? 'تفاصيل غير متوفرة',
    //       maxLines: 2,
    //       style: TextStyle(
    //         color: AppColor.secondaryColor,
    //         fontFamily: "cairoFonts",
    //         overflow: TextOverflow.ellipsis,
    //         fontSize: MediaQuery.sizeOf(context).width * 0.033,
    //       ),
    //     ),
    //     trailing: Icon(
    //       Icons.arrow_forward_ios,
    //       color: Colors.grey,
    //       size: MediaQuery.of(context).size.width * 0.04,
    //     ),
    //     onTap: () {
    //       /// remove
    //     },
    //   ),
    // );
  }
}
