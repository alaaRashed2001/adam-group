import 'package:adam_group/API/Api_Controllers/ad_api_controller.dart';
import 'package:adam_group/API/Api_Controllers/container_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Models/ads_model.dart';
import 'package:adam_group/Models/containers_model.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Widgets/ads_card_swiper.dart';
import 'package:adam_group/Screens/Widgets/shipment_widget.dart';
import 'package:adam_group/Widgets/images_no_data.dart';
import 'package:adam_group/Widgets/lottie_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with NavigatorHelper {
  List<ContainerModel> shipments = [];
  List<AdsModel> ads = [];

  bool _loadingAds = true;
  bool _loadingShipments = true;

  @override
  void initState() {
    super.initState();
    AdsApiController().getAds(context).then((list) {
      ads = list;
    }).catchError((e) {
    }).whenComplete(() {
      setState(() {
        _loadingAds = false;
      });
    });

    ContainerApiController().getContainers(context).then((data) {
      shipments = data;
    }).catchError((e) {
    }).whenComplete(() {
      setState(() {
        _loadingShipments = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.paddingOf(context).left + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _loadingAds
                ? const LottieLoader()
                : AdsCardSwiper(ads: ads),

            (MediaQuery.sizeOf(context).height * 0.03).height,

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

            Expanded(
              child: _loadingShipments
                  ? const LottieLoader()
                  : shipments.isNotEmpty
                  ? ListView.builder(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.paddingOf(context).bottom * 0.5,
                ),
                itemCount: shipments.length,
                itemBuilder: (context, index) =>
                    ShipmentWidget(container: shipments[index]),
              )
                  : const ImagesNoData(),
            ),
          ],
        ),
      ),
    );
  }
}

