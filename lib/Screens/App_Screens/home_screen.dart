import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
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
  static final List<String> offerImages = [
    'assets/images/offers/offer1.png',
    'assets/images/offers/offer2.png',
  ];
  final List<Map<String, dynamic>> shipments = [
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nكلي',
      'isFull': true,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nكلي',
      'isFull': true,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nجزئي',
      'isFull': false,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nكلي',
      'isFull': true,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nجزئي',
      'isFull': false,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nجزئي',
      'isFull': false,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nكلي',
      'isFull': true,
    },
    {
      'title': 'C1 2025.01.06 Islam A001',
      'date': '2025.02.01',
      'status': 'شحن\nجزئي',
      'isFull': false,
    },
  ];
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Swiper Section
            Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.paddingOf(context).top * 0.1,
              ),
              height: MediaQuery.sizeOf(context).height * 0.22,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.primaryColor,
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      offerImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                autoplay: true,
                itemCount: offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: AppColor.secondaryColor,
                    activeColor: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

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
                itemBuilder: (context, index) => ShipmentWidget(
                  title: shipments[index]['title'],
                  date: shipments[index]['date'],
                  status: shipments[index]['status'],
                  isFull: shipments[index]['isFull'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
