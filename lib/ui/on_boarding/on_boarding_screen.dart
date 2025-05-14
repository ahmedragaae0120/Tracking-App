// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/routes_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(right: 50, top: 150),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Transform.scale(
                  scale: 2,
                  child: Lottie.asset(
                    'assets/animations/onboarding_animation.json',
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppStrings.welcomeTo,
              style: TextStyle(fontSize: 22),
            ),
            Text(
              AppStrings.floweryRiderApp,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteManager.loginScreen);
                },
                borderColor: ColorManager.primaryColor,
                text: AppStrings.login,
                color: ColorManager.primaryColor,
                textColor: ColorManager.white),
            const SizedBox(
              height: 20,
            ),
            CustomTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteManager.applyScreen);
                },
                borderColor: ColorManager.black100.withOpacity(0.2),
                text: AppStrings.applyNow,
                color: ColorManager.white,
                textColor: ColorManager.black),
          ]),
        ),
      ),
    );
  }
}
