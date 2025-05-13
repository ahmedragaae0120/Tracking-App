import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/ui/tabs/profile_tab/language_part/Language_bottom_sheet/bottom_sheet.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const LanguageBottomSheet(),
          );
        },
        child: Text(
          style: const TextStyle(color: ColorManager.pinkBase),
          context.locale == const Locale('en')
              ? AppStrings.english
              : AppStrings.arabic,
        ));
  }
}
