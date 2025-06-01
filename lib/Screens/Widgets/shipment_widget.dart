import 'package:adam_group/API/Api_Controllers/tracking_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/converter_helper.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Helpers/out_app_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/containers_model.dart';
import 'package:adam_group/Screens/App_Screens/tracking_screen.dart';
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
    with ConverterHelper, SnackBarHelper, OutAppHelper, NavigatorHelper {
  bool _isDownloading = false;
  bool _isSharing = false;

  bool get isFull => widget.container.type == 0;
  bool get isDelivered => widget.container.isDelevired == 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var file = await convertLinkToFile(widget.container.publicUrl ?? '');
        await openThisFile(context, file);
      },
      child: Stack(
        children: [
          _buildBackgroundLayer(context),
          _buildForegroundContent(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundLayer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isFull ? AppColor.darkScaffoldColor : AppColor.primaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor),
      ),
      height: MediaQuery.sizeOf(context).height * 0.155,
    );
  }

  Widget _buildForegroundContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.03),
      decoration: BoxDecoration(
        color: isFull ? AppColor.lightScaffoldColor : AppColor.darkScaffoldColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor),
      ),
      child: Row(
        children: [
          _buildLabel(context),

          _buildFileAndStatus(context),
          // _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    // تحديد النص بناءً على اللغة ونوع الشحنة
    final labelText = isFull
        ? "${AppLocalizations.of(context)!.shipment} ${AppLocalizations.of(context)!.full}"
        : "${AppLocalizations.of(context)!.shipment} ${AppLocalizations.of(context)!.partial}";

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.14,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: isFull ? AppColor.darkScaffoldColor : AppColor.primaryColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 3, // 270 درجة لعرض النص عمودياً من فوق لتحت
          child: Text(
            labelText,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: "cairoFonts",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildFileAndStatus(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04),
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              widget.container.fileName ?? 'bad file',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "cairoFonts",
                color: isFull
                    ? AppColor.darkScaffoldColor
                    : AppColor.primaryColor,
              ),
            ),

16.height,

            // Row الأيقونات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActions(context),
                8.width,
                Text(
                  isDelivered
                      ? AppLocalizations.of(context)!.delivered
                      : AppLocalizations.of(context)!.tracking,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "almaraiFonts",
                    fontWeight: FontWeight.bold,
                    color: isDelivered ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        _buildIconAction(
          icon: Icons.cloud_download,
          isLoading: _isDownloading,
          onTap: _download,
        ),
        (MediaQuery.sizeOf(context).width * 0.01).width,
        _buildIconAction(
          icon: Icons.share,
          isLoading: _isSharing,
          onTap: _share,
        ),
        if (!isDelivered) ...[
          (MediaQuery.sizeOf(context).width * 0.01).width,
          _buildIconAction(
            icon: Icons.location_searching,
            isLoading: false,
            onTap: _openTrackingIfAvailable,
          ),
        ],
      ],
    );
  }

  Widget _buildIconAction({
    required IconData icon,
    required bool isLoading,
    required Future<void> Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width * 0.054,
        backgroundColor:
            isFull ? AppColor.darkScaffoldColor : AppColor.primaryColor,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Icon(
                icon,
                size: MediaQuery.sizeOf(context).width * 0.08,
                color:
                    isFull ? AppColor.primaryColor : AppColor.darkScaffoldColor,
              ),
      ),
    );
  }

  Future<void> _openTrackingIfAvailable() async {
    final trackingNumber = widget.container.trackingNumber;
    if (trackingNumber != null && trackingNumber.isNotEmpty) {
      await openTrackingDetails(context, trackingNumber);
    } else {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.trackingNumberNotAvailable,
        error: true,
      );
    }
  }

  Future<void> openTrackingDetails(
      BuildContext context, String trackingNumber) async {
    final controller = TrackingApiController();
    final tracking = await controller.getTracking(context, trackingNumber);
    if (tracking != null) {
      jump(context, screen: TrackingDetailsScreen(response: tracking));
    } else {
      showSnackBar(context,
          message:
              AppLocalizations.of(context)!.trackingInformationNotAvailableYet,
          error: true);
    }
  }

  Future<void> _download() async {
    setState(() => _isDownloading = true);
    try {
      String link = widget.container.publicUrl ?? '';
      await downloadAndSaveImage(link);
      showSnackBar(context,
          message: AppLocalizations.of(context)!.downloadSuccessfully,
          error: false);
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _share() async {
    setState(() => _isSharing = true);
    try {
      String link = widget.container.publicUrl ?? '';
      var file = await convertLinkToFile(link);
      await shareThisFile(file);
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() => _isSharing = false);
    }
  }
}
