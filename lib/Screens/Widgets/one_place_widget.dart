import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Models/places_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adam_group/Screens/Inner_Screen/details_one_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnePlaceWidget extends StatefulWidget {
  const OnePlaceWidget({
    super.key,
    required this.place,
  });

  final PlaceModel place;

  @override
  State<OnePlaceWidget> createState() => _OnePlaceWidgetState();
}

class _OnePlaceWidgetState extends State<OnePlaceWidget> with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        jump(context,
            screen: DetailsOnePlace(
              place: widget.place,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: Image.network(
                  widget.place.publicUrl!,
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.place.name ?? '',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontFamily: "almaraiFonts",
                          ),
                        ),
                        (6.h).height,
                        Text(
                          '${widget.place.country ?? ''}, ${widget.place.city ?? ''}',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "cairoFonts",
                          ),
                        ),
                      ],
                    ),
                  ),
                  (MediaQuery.sizeOf(context).width * 0.02).width,
                  InkWell(
                    onTap: () {
                      jump(context,
                          screen: DetailsOnePlace(
                            place: widget.place,
                          ));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4.0,
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
                      child:  Text(
                        AppLocalizations.of(context)!.showDetails,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontFamily: "almaraiFonts",
                          fontWeight: FontWeight.bold,
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
    );
  }
}
