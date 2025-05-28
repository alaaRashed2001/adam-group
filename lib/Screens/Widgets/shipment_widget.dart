import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/converter_helper.dart';
import 'package:adam_group/Helpers/out_app_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/containers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShipmentWidget extends StatefulWidget {
  final ContainerModel container;

  const ShipmentWidget({
    super.key,
    required this.container,
  });

  @override
  State<ShipmentWidget> createState() => _ShipmentWidgetState();
}

class _ShipmentWidgetState extends State<ShipmentWidget>
    with ConverterHelper, SnackBarHelper, OutAppHelper {
  bool get isFull => widget.container.type == 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var file = await convertLinkToFile(widget.container.publicUrl ?? '');
        await openThisFile(context, file);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color:
                    isFull ? AppColor.darkScaffoldColor : AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.borderColor)),
            height: MediaQuery.sizeOf(context).height * 0.105,
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.sizeOf(context).height * 0.03),
            decoration: BoxDecoration(
              color:
                  isFull ? AppColor.primaryColor : AppColor.darkScaffoldColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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
                    isFull
                        ? "${AppLocalizations.of(context)!.shipment}\n${AppLocalizations.of(context)!.full} "
                        : "${AppLocalizations.of(context)!.shipment}\n${AppLocalizations.of(context)!.partial} ",
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
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.container.fileName ?? '',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "cairoFonts",
                            overflow: TextOverflow.ellipsis,
                            color: isFull
                                ? AppColor.darkScaffoldColor
                                : AppColor.primaryColor,
                          ),
                        ),
                        8.height,
                        Text(
                          '${convertStringDateToDateTime(widget.container.createdAt)}\n${convertStringDateToDateTime(widget.container.updatedAt)}',
                          style: TextStyle(
                            fontSize: 12.sp,
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

                /// Icons
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02,
                      vertical: MediaQuery.sizeOf(context).height * 0.02),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Download
                      InkWell(
                        onTap: () async => await _download(),
                        child: CircleAvatar(
                          radius: MediaQuery.sizeOf(context).width * 0.054,
                          backgroundColor: isFull
                              ? AppColor.darkScaffoldColor
                              : AppColor.primaryColor,
                          child: !_loading
                              ? Icon(
                                  Icons.cloud_download,
                                  size: MediaQuery.sizeOf(context).width * 0.08,
                                  color: isFull
                                      ? AppColor.primaryColor
                                      : AppColor.darkScaffoldColor,
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),

                      /// Share
                      InkWell(
                        onTap: () async => await _share(),
                        child: CircleAvatar(
                          radius: MediaQuery.sizeOf(context).width * 0.054,
                          backgroundColor: isFull
                              ? AppColor.darkScaffoldColor
                              : AppColor.primaryColor,
                          child: !_loading
                              ? Icon(
                                  Icons.share,
                                  size: MediaQuery.sizeOf(context).width * 0.08,
                                  color: isFull
                                      ? AppColor.primaryColor
                                      : AppColor.darkScaffoldColor,
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _loading = false;
  Future<void> _download() async {
    try {
      String link = widget.container.publicUrl ?? '';

      /// Download
      await downloadAndSaveImage(link);
      showSnackBar(context,
          message: AppLocalizations.of(context)!.downloadSuccessfully,
          error: false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _share() async {
    try {
      String link = widget.container.publicUrl ?? '';

      /// Share
      var file = await convertLinkToFile(link);
      print(file.path);
      await shareThisFile(file);
    } catch (e) {
      print(e.toString());
    }
  }
  /* Future<void> _downloadAndShare() async {
    setState(() {
      _loading = true;
    });

    try {
      String link = widget.container.publicUrl ?? '';

      /// Download
      await downloadAndSaveImage(link);
      showSnackBar(context,
          message: AppLocalizations.of(context)!.downloadSuccessfully,
          error: false);
      /// Share
      var file = await convertLinkToFile(link);
      print(file.path);
      await shareThisFile(file);
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _loading = false;
    });
  }*/
}
