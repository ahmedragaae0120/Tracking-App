import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 80,
      decoration: const BoxDecoration(
          color: ColorManager.grey,
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
