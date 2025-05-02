import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class CustomSearchBar extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  void Function()? onTap;
  void Function(String)? onSubmitted;
  bool readOnly;

  CustomSearchBar(
      {super.key,
      required this.margin,
      this.onTap,
      required this.readOnly,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorManager.white70,
          width: 1,
        ),
      ),
      child: TextField(
        onTap: onTap,
        onSubmitted: onSubmitted,
        readOnly: readOnly,
        decoration: InputDecoration(
          // hintText: AppStrings.search,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
