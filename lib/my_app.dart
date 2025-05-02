import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/config/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //     String initialRoute() {
    //   bool? rememberMe = CacheHelper.getRememberMe();
    //   print("$rememberMe ⭐⭐⭐⭐⭐⭐⭐⭐");
    //   return rememberMe == true
    //       ? RouteManager.mainScreen
    //       : RouteManager.loginScreen;
    // }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: {},
        // initialRoute: initialRoute(),
        home: Scaffold(body: Center(child: Text('Hello, Flutter!'))));
  }
}
