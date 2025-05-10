import 'package:flutter/material.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildAnimatedCircle(double radius, Color color, double delay) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.15).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(delay, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 60),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    buildAnimatedCircle(90, ColorManager.lightGreen3, 0.2),
                    buildAnimatedCircle(70, ColorManager.lightGreen2, 0.4),
                    buildAnimatedCircle(50, ColorManager.lightGreen1, 0.8),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: ColorManager.lightGreen,
                      child: Icon(
                        Icons.check_rounded,
                        size: 50,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.thankYou,
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Text(
                  AppStrings.theOrderDeliveredSuccessfully,
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: ColorManager.black,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, RouteManager.loginScreen);
                  },
                  borderColor: ColorManager.primaryColor,
                  text: AppStrings.done,
                  color: ColorManager.primaryColor,
                  textColor: ColorManager.backgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
