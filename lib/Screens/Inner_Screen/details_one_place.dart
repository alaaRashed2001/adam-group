import 'package:adam_group/API/Api_Controllers/place_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/out_app_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/places_model.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsOnePlace extends StatefulWidget {
  final PlaceModel place;

  const DetailsOnePlace({required this.place, super.key});

  @override
  State<DetailsOnePlace> createState() => _DetailsOnePlaceState();
}

class _DetailsOnePlaceState extends State<DetailsOnePlace>
    with SnackBarHelper, OutAppHelper {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init;
  }

  Future<void> get _init async {
    await _getDetails;
    setState(() {
      _loading = false;
    });
  }

  bool _loading = true;

  Future<void> get _getDetails async {
    try {
      var data = await PlaceApiController()
          .getPlaceById(context, widget.place.id.toString());
      _placeModel = data;
    } catch (e) {
      ///
    }
  }

  late PlaceModel? _placeModel = widget.place;

  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(),
      body: !_loading
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _placeModel?.name ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontFamily: "cairoFonts",
                          ),
                        ),
                        (6.h).height,
                        Text(
                          '${_placeModel?.country ?? ''}, ${_placeModel?.city ?? ''}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: color,
                            fontFamily: "cairoFonts",
                          ),
                        ),
                        (8).height,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              child: Image.network(
                                _placeModel?.publicUrl ?? '',
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.35,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.broken_image,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        (12.h).height,
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Center(
                                  child: Text(
                                    _placeModel?.description ?? '',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: color,
                                      fontFamily: "cairoFonts",
                                    ),
                                    maxLines: isShowMore ? 3 : null,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isShowMore = !isShowMore;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    isShowMore ? "Show more" : "Show less",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColor.primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                (24).height,
                GradientButton(
                  text: "عرض الموقع على الخريطة",
                  textSize: 14.sp,
                  horizontalPadding: 16.w,
                  onPressed: () async {
                    await launchThisUrl(context, _placeModel?.location ?? '');
                  },
                ),
                (24).height,
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
