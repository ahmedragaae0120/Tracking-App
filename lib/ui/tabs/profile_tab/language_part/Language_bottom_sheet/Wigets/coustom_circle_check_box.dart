import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class CoustomCircleCheckBox extends StatelessWidget {
  final bool isSelected;

  const CoustomCircleCheckBox({required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? ColorManager.pink : Colors.grey,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.pink,
                ),
              ),
            )
          : null,
    );
  }
}
