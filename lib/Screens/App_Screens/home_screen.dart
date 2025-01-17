import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:adam_group/Screens/Widgets/shipment_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Swiper Section
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              height: MediaQuery.of(context).size.height * 0.22,
              decoration: BoxDecoration(
                color: Colors.black, // لون خلفية الـ Container
                borderRadius:
                    BorderRadius.circular(20), // تحديد الزوايا المستديرة
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.primaryColor, // ظل بلون ذهبي خفيف
                    spreadRadius: 1, // مقدار انتشار الظل
                    blurRadius: 7, // مقدار ضبابية الظل
                    offset: Offset(0, 3), // إزاحة الظل (يمين/أسفل)
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
            const SizedBox(height: 14),

            /// Shipments Section
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.shipments,
                  style: TextStyle(
                    color: color,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "cairoFonts",
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: AppColor.primaryColor,
                  // indent: 100,
                  endIndent: 200,
                )
              ],
            ),

            /// ListView Section (Scrollable)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
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
