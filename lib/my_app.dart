import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/core/utils/routes_manager.dart';

import 'ui/Auth/success_apply/view/apply_success.dart';

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
        routes: {
          RouteManager.applySuccess: (context) => ApplySuccess(),
        },
        initialRoute: RouteManager.applySuccess,
        home: Scaffold(body: Center(child: Text('Hello, Flutter!'))));
  }
}
