import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTabChanged;
  final int selectedIndex;
  final TabController controller;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.selectedIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTabChanged,
      controller: controller,
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      labelColor: Theme.of(context).colorScheme.primary,
      tabs: tabs.map((title) => Tab(text: title)).toList(),
    );
  }
}
