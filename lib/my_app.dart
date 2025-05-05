import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/ui/Auth/login/login_screen.dart';
import 'package:tracking_app/ui/main_screen.dart';
import 'core/cache/shared_pref.dart';
import 'core/utils/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute() {
      bool? rememberMe = CacheHelper.getRememberMe();
      print("$rememberMe ⭐⭐⭐⭐⭐⭐⭐⭐");
      return rememberMe == true
          ? RouteManager.mainScreen
          : RouteManager.loginScreen;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: {

          RouteManager.loginScreen: (context) => const SignInScreen(),
          RouteManager.mainScreen: (context) =>  MainScreen(),

        },
        initialRoute: initialRoute(),
        );
  }
}
