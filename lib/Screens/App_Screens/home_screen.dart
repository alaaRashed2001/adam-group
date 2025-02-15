import 'package:adam_group/API/Api_Controllers/ad_api_controller.dart';
import 'package:adam_group/API/Api_Controllers/container_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Models/ads_model.dart';
import 'package:adam_group/Models/containers_model.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Widgets/ads_card_swiper.dart';
import 'package:adam_group/Screens/Widgets/shipment_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ContainerModel> shipments = [];
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
    await _getContainers;
    setState(() {
      _loading = false;
    });
  }

  Future<void> get _getContainers async {
    try {
      var data = await ContainerApiController().getContainers(context);
      shipments = data;
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

                  /// Shipments Section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.shipments,
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
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.paddingOf(context).bottom * 0.5,
                      ),
                      itemCount: shipments.length,
                      itemBuilder: (context, index) =>
                          ShipmentWidget(container: shipments[index]),
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
