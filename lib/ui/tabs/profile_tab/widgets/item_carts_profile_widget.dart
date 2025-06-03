import 'package:flutter/material.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class ItemCartsProfileWidget extends StatelessWidget {
  final IconData? icon;
  final String title;
  final IconData? iconArrow;
  final String? textLanguage;
  final VoidCallback? onAction;

  const ItemCartsProfileWidget(
      {super.key,
      this.icon,
      required this.title,
      this.iconArrow,
      this.textLanguage,
      required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorManager.black,
          size: 25,
        ),
        SizedBox(width: 5),
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.bodySmall
              ?.copyWith(color: ColorManager.black),
        ),
        const Spacer(),
        IconButton(
          onPressed: onAction,
          icon: Icon(
            iconArrow,
            color: ColorManager.grey,
            size: 25,
          ),
        ),
      ],
    );
  }
}
