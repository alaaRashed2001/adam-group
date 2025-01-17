import 'package:adam_group/Consts/theme_data.dart';
import 'package:adam_group/Providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Providers/lang_provider.dart';
import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider<LangProvider>(
          create: (context) => LangProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return MaterialApp(
                title: 'Recipe Finder',
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(isDarkTheme: false, context: context),
                darkTheme:
                    Styles.themeData(isDarkTheme: true, context: context),
                themeMode: themeProvider.isDarkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                ],
                locale: Locale(Provider.of<LangProvider>(context).lang),
                home: const SplashScreen(),
              );
            });
      }),
    );
  }
}
