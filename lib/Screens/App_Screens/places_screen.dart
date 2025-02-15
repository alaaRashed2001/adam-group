import 'package:adam_group/API/Api_Controllers/ad_api_controller.dart';
import 'package:adam_group/API/Api_Controllers/place_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Models/ads_model.dart';
import 'package:adam_group/Models/places_model.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Auth_Screens/login_screen.dart';
import 'package:adam_group/Screens/Widgets/ads_card_swiper.dart';
import 'package:adam_group/Screens/Widgets/one_place_widget.dart';
import 'package:adam_group/Screens/welcom_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> with NavigatorHelper {
  List<PlaceModel> places = [];

  List<AdsModel> ads = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init;
  }

  bool _loading = true;

  Future<void> get _init async {
    await _getAds;
    await _getPlaces;

    setState(() {
      _loading = false;
    });
  }

  Future<void> get _getPlaces async {
    try {
      var list = await PlaceApiController().getPlaces(context);
      places = list;
    } catch (e) {
      ///
    }
  }

  Future<void> get _getAds async {
    try {
      var list = await AdsApiController().getAds(context);
      ads = list;
    } catch (e) {
      ///
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>      Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),

          icon:  Icon(
            Provider.of<ThemeProvider>(context).isDarkTheme
                ? Icons.dark_mode
                : Icons.light_mode,
            color: AppColor.primaryColor,
            size: 26,
          ),
        ),
        title: const Text(
          "صباح الخير ",
          style: TextStyle(
            // fontSize: 12,
            fontFamily: "cairoFonts",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              jump(context, screen: const LoginScreen());
            },
            icon: const Icon(
              Icons.account_box_outlined,
              color: AppColor.primaryColor,
              size: 26,
            ),
          ),
        ],
      ),
      body: !_loading
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.paddingOf(context).left + 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Swiper Section
                  AdsCardSwiper(ads: ads),

                  (MediaQuery.sizeOf(context).height * 0.04).height,

                  /// Places Section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       'اماكن في الصين',
                      //  ' اماكن في ${places.first.city}'
                        style: TextStyle(
                          color: color,
                          fontSize: MediaQuery.sizeOf(context).width * 0.05,
                          fontWeight: FontWeight.w700,
                          fontFamily: "cairoFonts",
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: AppColor.primaryColor,
                        endIndent: MediaQuery.sizeOf(context).width * 0.4,
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: places.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.83, // نسبة العرض إلى الارتفاع
                        crossAxisSpacing:
                            MediaQuery.sizeOf(context).width * 0.03,
                        mainAxisSpacing:
                            MediaQuery.sizeOf(context).width * 0.03,
                      ),
                      itemBuilder: (context, index) {
                        final place = places[index];

                        return OnePlaceWidget(place: place);
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
