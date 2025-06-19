// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/ui/Auth/apply/apply_screen.dart';
import 'package:tracking_app/ui/Auth/forget_password/forget_password.dart';
import 'package:tracking_app/ui/Auth/forget_password/reset_password.dart';
import 'package:tracking_app/ui/Auth/forget_password/verfiy_password.dart';
import 'package:tracking_app/ui/Auth/login/login_screen.dart';
import 'package:tracking_app/ui/on_boarding/on_boarding_screen.dart';
import 'package:tracking_app/ui/tabs/main_tab/main_screen.dart';
import 'package:tracking_app/ui/tabs/profile_tab/change_password/change_password_screen.dart';
import 'package:tracking_app/ui/tabs/profile_tab/change_password/cubit/change_password_cubit.dart';
import 'package:tracking_app/ui/tabs/profile_tab/edit_profile_screen/edit_profile_screen.dart';
import 'package:tracking_app/ui/tabs/profile_tab/edit_profile_screen/view_model/edit_profile_cubit.dart';
import 'package:tracking_app/ui/tabs/profile_tab/widgets/edit_vehicle.dart';

import 'core/cache/shared_pref.dart';
import 'core/di/di.dart';
import 'core/utils/routes_manager.dart';
import 'ui/Auth/success_apply/view/apply_success.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute() {
      bool? rememberMe = CacheHelper.getRememberMe();
      print("$rememberMe ⭐⭐⭐⭐⭐⭐⭐⭐");

//  String? currentOrderId = CacheHelper.getData<String>('current_order_id');
      // if (currentOrderId != null && currentOrderId.isNotEmpty) {
      //   return RouteManager.orderDetailsScreen;
      // }

      return rememberMe == true
          ? RouteManager.mainScreen
          : RouteManager.onBoardingScreen;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        RouteManager.changePasswordScreen: (context) => BlocProvider(
              create: (context) => getIt<ChangePasswordCubit>(),
              child: const ChangePasswordScreen(),
            ),
        RouteManager.editProfileScreen: (context) => BlocProvider(
              create: (context) => getIt<EditProfileCubit>(),
              child: EditProfileScreen(),
            ),
        RouteManager.applySuccess: (context) => ApplySuccess(),
        RouteManager.loginScreen: (context) => const SignInScreen(),
        RouteManager.applyScreen: (context) => const ApplyScreen(),
        RouteManager.mainScreen: (context) => MainScreen(),
        RouteManager.onBoardingScreen: (context) => OnBoardingScreen(),
        RouteManager.emailVerificationScreen: (context) =>
            const VerifyResetCodeScreen(),
        RouteManager.resetPasswordScreen: (context) =>
            const ResetPasswordScreen(),
        RouteManager.forgetPasswordScreen: (context) =>
            const ForgetPasswordScreen(),
        RouteManager.editVehicle: (context) =>
             EditVehicle(),
      },
      initialRoute: initialRoute(),
    );
  }
}
