import 'dart:async';
import 'dart:io';
import 'package:child_community/routes.dart';
import 'package:child_community/service/localization/local_string.dart';
import 'package:child_community/service/themes/app_theme.dart';
import 'package:child_community/util/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'common/controller/localization_controller.dart';
import 'common/controller/theme_controller.dart';
import 'locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  Map<String, Map<String, String>> localString = await di.init();
  runApp( MyApp(localString: localString,));
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final Map<String, Map<String, String>> localString;
  const MyApp({super.key, required this.localString});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme) {
      return GetBuilder<LocalizationController>(builder: (local) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => GetMaterialApp(
            // translations: Languages(),
            locale: local.locale,
            // locale: Get.deviceLocale,
            translations: LocaleString(localString: widget.localString),
            // fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
            fallbackLocale: const Locale('en', 'US'),
            title: ShareKey.appName,
            initialRoute:  RouterHelper.loginScreen,
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
            getPages: RouterHelper.routes,
            navigatorKey: Get.key,
            theme: AppTheme.theme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme.themeMode,
            debugShowCheckedModeBanner: false,
          ),
        );
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}