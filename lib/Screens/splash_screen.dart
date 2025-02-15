import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Firebase/Firebase_Messaging/fb_notifications.dart';
import 'package:adam_group/Helpers/navigator_helper.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Screens/bottom_navigat_bar.dart';
import 'package:adam_group/Screens/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigatorHelper, FbNotifications {
  Future<void> navigate() async {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 6), () {
      jump(
        context,
        screen:
            auth.isLoggedIn ? const BottomNavigateBar() : const WelcomeScreen(),
        replace: true,
      );
    });
  }

  Future<void> _init() async {
    callNotifications;
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

           62.height,

          Image.asset(
            'assets/images/logo.png',
            width: 380,
          ),
          32.height,
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
