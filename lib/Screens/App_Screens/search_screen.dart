import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/generated/assets.dart';
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
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.searchShipment,
          style: TextStyle(
            color: color,
            fontSize: MediaQuery.sizeOf(context).width * 0.05,
            fontWeight: FontWeight.w700,
            fontFamily: "cairoFonts",
          ),
        ),
      ),
      body: Center(
        child: Image.asset(
          Assets.imagesNoData,
          width: MediaQuery.sizeOf(context).width * 0.6,
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
