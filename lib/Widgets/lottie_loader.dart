import 'package:adam_group/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatelessWidget {
  const LottieLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child:   Lottie.asset(
        Assets.lottieLoader,
        width: 165,
        height: 188,
      ),
    );
  }
}