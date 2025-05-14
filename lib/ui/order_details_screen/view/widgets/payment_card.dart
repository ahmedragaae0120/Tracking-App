// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';

class PaymentCard extends StatelessWidget {
  String lable;
  String value;
  PaymentCard({required this.lable, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Text(
              lable,
              style: AppTextStyle.medium16,
            ),
            const Spacer(),
            Text(value,
                style: AppTextStyle.medium14
                    .copyWith(color: ColorManager.white80)),
          ],
        ),
      ),
    );
  }
}
