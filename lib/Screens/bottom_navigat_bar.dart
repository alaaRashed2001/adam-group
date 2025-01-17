import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/App_Screens/home_screen.dart';
import 'package:adam_group/Screens/App_Screens/profile_screen.dart';
import 'package:adam_group/Screens/App_Screens/search_screen.dart';
import 'package:adam_group/Screens/App_Screens/statement_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Icon(
            Provider.of<ThemeProvider>(context).isDarkTheme
                ? Icons.dark_mode
                : Icons.light_mode,
            color: AppColor.primaryColor,
            size: 26,
          ),
        ),
        title: const Text(
          "صباح الخير ابو الوليد",
          style: TextStyle(
            fontSize: 12,
            fontFamily: "cairoFonts",
          ),
        ),
        actions: [
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
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkTheme
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
              Icons.search,
              color: currentPage == 2
                  ? AppColor.primaryColor
                  : AppColor.secondaryColor,
            ),
            label: AppLocalizations.of(context)!.search,
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
          SearchScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
