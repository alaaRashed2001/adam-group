import 'package:adam_group/API/Api_Controllers/place_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Models/places_model.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Widgets/one_place_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PlacesInChina extends StatefulWidget {
  const PlacesInChina({super.key});

  @override
  State<PlacesInChina> createState() => _PlacesInChinaState();
}

class _PlacesInChinaState extends State<PlacesInChina> {
  List<PlaceModel> places = [];


  @override
  void initState() {
    super.initState();
    _init;
  }

  bool _loading = true;

  Future<void> get _init async {

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
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child:  Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.paddingOf(context).left + 24,
            ),
            child: Column(
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.guideChina,
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
                (MediaQuery.sizeOf(context).height * 0.02).height,
                Expanded(
                  child: GridView.builder(
                    itemCount: places.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.83,
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

      ),
    );
  }
}
