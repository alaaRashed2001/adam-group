import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Providers/lang_provider.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/App_Screens/home_screen.dart';
import 'package:adam_group/Screens/App_Screens/places_in_china.dart';
import 'package:adam_group/Screens/App_Screens/profile_screen.dart';
import 'package:adam_group/Screens/App_Screens/statement_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'App_Screens/notification_screen.dart';

class BottomNavigateBar extends StatefulWidget {
  const BottomNavigateBar({super.key});

  @override
  State<BottomNavigateBar> createState() => _BottomNavigateBarState();
}

class _BottomNavigateBarState extends State<BottomNavigateBar> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthProvider, ThemeProvider, LangProvider>(
      builder: (context, auth, theme,lang, child) {
        return Scaffold(
          appBar: AppBar(
            leading:
            IconButton(
              onPressed: () =>
                theme.toggleTheme(),
              icon: Icon(
                theme.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: AppColor.primaryColor,
                size: 26,
              ),
            ),
            title:  Text(

             "${AppLocalizations.of(context)!.welcome} ${auth.userModel?.name}",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "cairoFonts",
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  lang.changeLanguage();
                },
                icon: const Icon(
                  Icons.language,
                  color: AppColor.primaryColor,
                ),
                color: AppColor.lightScaffoldColor,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: "ar",
                    child: Text(
                      "العربية",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "cairoFonts",
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "en",
                    child: Text(
                      "English",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "cairoFonts",
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ));
                },
                icon: const Icon(
                  Icons.notifications,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: theme.isDarkTheme
                ? AppColor.darkScaffoldColor
                : AppColor.lightScaffoldColor,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
              _pageController.jumpToPage(index);
            },
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: AppColor.secondaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: currentPage == 0
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                  color: currentPage == 1
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                ),
                label: AppLocalizations.of(context)!.statement,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                //  Icons.search,
                  Icons.location_on_outlined,
                  color: currentPage == 2
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                ),
                label: AppLocalizations.of(context)!.guideChina,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: currentPage == 3
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                ),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            controller: _pageController,
            children: const [
              HomeScreen(),
              StatementScreen(),
              PlacesInChina(),
              ProfileScreen(),
            ],
          ),
        );
      },
    );
  }
}
