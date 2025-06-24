// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_intent.dart';
import 'package:tracking_app/ui/tabs/home_tab/view/home_screen.dart';
import 'package:tracking_app/ui/tabs/profile_tab/profile_screen.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/string_manager.dart';
import '../orders_tab/view/orders_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialTab;
  String? selectedCategoryId;

  MainScreen({
    super.key,
    this.initialTab = 0,
    this.selectedCategoryId,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    AuthCubit.get(context).doIntent(getLoginDriverDataIntent());

    _screens = [
      HomeScreen(),             // Tab 0: Home
      OrdersScreen(),            // Tab 1: OrdersScreen
      ProfileScreen(),          // Tab 2: Profile
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: AppStrings.orders,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: AppStrings.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
        backgroundColor: ColorManager.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
