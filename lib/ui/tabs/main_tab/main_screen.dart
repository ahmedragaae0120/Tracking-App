// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_intent.dart';
import 'package:tracking_app/ui/tabs/home_tab/view/home_screen.dart';

import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/string_manager.dart';
import '../orders_tab/view/orders_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialTab;
  String? selectedCategoryId; // Remove 'final' here

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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    AuthCubit.get(context).doIntent(getLoginDriverDataIntent());
  }

  void _onItemTapped(int index) {
    // if ((index == 2 || index == 3)) {
    //   //Dialogs.restrictedAccess(context, () => Navigator.pop(context));
    //   return;
    if ((index == 3)) {
      //Dialogs.restrictedAccess(context, () => Navigator.pop(context));
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          OrdersScreen(),
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            label: AppStrings.orders,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_2_outlined),
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
