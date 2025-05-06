import 'package:flutter/material.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/utils/assets_manager.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/routes_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';

class ApplySuccess extends StatelessWidget {
  const ApplySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AssetsManager.backgroundCard,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 194, horizontal: 30),
            child: Center(
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 100,
                    color: ColorManager.primaryColor,
                  ),
                  Text(
                    AppStrings.yourApplicationHasBeenSubmitted,
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  Text(
                    AppStrings.thankYouForProviding,
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodySmall
                        ?.copyWith(fontSize: 16),
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteManager.loginScreen);
                    },
                    borderColor: ColorManager.primaryColor,
                    text: AppStrings.login,
                    color: ColorManager.primaryColor,
                    textColor: ColorManager.backgroundColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
