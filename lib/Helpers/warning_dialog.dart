import 'package:adam_group/Consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin WarningDialogHelper {
  void navigateTo(
      {required BuildContext context, required Widget destination}) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => destination));
  }

  Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function onPressed,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 30,
                width: 30,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: "cairoFonts",
                ),
              ),
            ]),
            content: Text(
              subtitle,
              style: const TextStyle(
                fontFamily: "cairoFonts",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18.sp,
                    fontFamily: "cairoFonts",
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  onPressed();
                },
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontFamily: "cairoFonts",
                  ),
                ),
              ),
            ],
          );
        });
  }
}
