import 'dart:async';
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
import 'package:adam_group/Widgets/images_no_data.dart';
import 'package:adam_group/Widgets/lottie_loader.dart';
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

  bool adsLoading = true;
  bool placesLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.wait([
      _getAds(),
      _getPlaces(),
    ]);
  }

  Future<void> _getPlaces() async {
    try {
      var list = await PlaceApiController().getPlaces(context);
      places = list;
    } catch (e) {
    } finally {
      setState(() {
        placesLoading = false;
      });
    }
  }

  Future<void> _getAds() async {
    try {
      var list = await AdsApiController().getAds(context);
      ads = list;
    } catch (e) {
    } finally {
      setState(() {
        adsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => themeProvider.toggleTheme(),
          icon: Icon(
            themeProvider.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
            color: AppColor.primaryColor,
            size: 26,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.welcome,
          style: const TextStyle(
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.paddingOf(context).left + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            adsLoading
                ?

           const LottieLoader()
                : AdsCardSwiper(ads: ads),

            (MediaQuery.sizeOf(context).height * 0.04).height,

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.placesChina,
                  style: TextStyle(
                    color: color,
                    fontSize: MediaQuery.sizeOf(context).width * 0.05,
                    fontWeight: FontWeight.w700,
                    fontFamily: "almaraiFonts",
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
              child: placesLoading
                  ? const LottieLoader()
                  : places.isEmpty
                  ?  const ImagesNoData()
                  : GridView.builder(
                itemCount: places.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.83,
                  crossAxisSpacing: MediaQuery.sizeOf(context).width * 0.03,
                  mainAxisSpacing: MediaQuery.sizeOf(context).width * 0.03,
                ),
                itemBuilder: (context, index) {
                  final place = places[index];
                  return OnePlaceWidget(place: place);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}


