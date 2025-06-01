import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Models/ads_model.dart';
import 'package:adam_group/Widgets/lottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class AdsCardSwiper extends StatefulWidget {
  const AdsCardSwiper({
    super.key,
    required this.ads,
  });

  final List<AdsModel> ads;

  @override
  State<AdsCardSwiper> createState() => _AdsCardSwiperState();
}

class _AdsCardSwiperState extends State<AdsCardSwiper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.primaryColor,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          var ad = widget.ads[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Image.network(
                  ad.publicUrl ?? "",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const LottieLoader();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child:
                          Icon(Icons.broken_image, size: 50, color: Colors.red),
                    );
                  },
                ),
              ],
            ),
          );
        },
        autoplay: true,
        itemCount: widget.ads.length,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
