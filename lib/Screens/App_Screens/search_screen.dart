import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.searchShipment,
                    style: TextStyle(
                      color: color,
                      fontSize: MediaQuery.sizeOf(context).width * 0.05,
                      fontWeight: FontWeight.w700,
                      fontFamily: "cairoFonts",
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
                  Container(
                    height: 2,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.startColor,
                          AppColor.endColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),


              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.shipmentNumber,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02,
                      vertical: MediaQuery.sizeOf(context).height * 0.015,
                    ),
                    child: Image.asset(
                      "assets/images/bottom/search.png",
                      width: MediaQuery.sizeOf(context).width * 0.05,
                    ),
                  ),
                  border: buildOutlineInputBorder(),
                  focusedBorder: buildOutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04,
                    vertical: MediaQuery.sizeOf(context).height * 0.018,
                  ),
                ),
                onChanged: (value) {

                  print('Search query: $value');
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),


              Center(
                child: Image.asset(
                  "assets/images/noData.png",
                  width: MediaQuery.sizeOf(context).width * 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        color: AppColor.borderColor,
        width: 1.0,
      ),
    );
  }
}
