import 'package:adam_group/Screens/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigate() async {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ));
    });
  }

  Future<void> _init() async {
    await navigate();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 62.h,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 380,
          ),
          SizedBox(
            height: 32.h,
          ),
          Lottie.asset(
            'assets/lottie/loader.json',
            width: 165,
            height: 188,
          ),
        ],
      ),
    );
  }
}
