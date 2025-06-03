// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    fontFamily: 'Inter',

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(ColorManager.white),
      trackColor: MaterialStateProperty.all(ColorManager.primaryColor),
      overlayColor: MaterialStateProperty.all(ColorManager.white70),
      trackOutlineColor: WidgetStateProperty.all(ColorManager.primaryColor),
    ),

    // 🎨 ألوان التطبيق
    colorScheme: const ColorScheme.light(
      primary: ColorManager.primaryColor,
      // اللون الأساسي
      secondary: Colors.black87,
      surface: Colors.white,
      // سطح البطاقات
      onPrimary: Colors.white,
      // لون النص على اللون الأساسي
      onSecondary: Colors.black,
      // لون النص على الخلفية
      error: ColorManager.errorColor,
      onError: Colors.white,
      onSurface: Colors.black87, // لون النص على البطاقات
    ),

    // 📝 نصوص التطبيق
    textTheme: const TextTheme(
        titleSmall: TextStyle(
          fontSize: 11,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        titleMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: ColorManager.green,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: ColorManager.grey,
        )),

    // 🔹 شريط التطبيق العلوي (AppBar)
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // 🔘 تصميم الأزرار (Buttons)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(343, 43),
        backgroundColor: ColorManager.addToCartButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            backgroundColor: ColorManager.pinkBase,
            foregroundColor: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            disabledBackgroundColor: ColorManager.black30,
            disabledForegroundColor: ColorManager.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ))),

    // ✏️ تصميم الحقول النصية (TextFields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.pinkAccent),
      ),
    ),

    // 🏠 تصميم شريط التنقل السفلي (Bottom Navigation Bar)
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ColorManager.primaryColor,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
    ),

    tabBarTheme: const TabBarTheme(
      labelColor: ColorManager.primaryColor,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: ColorManager.primaryColor,
      unselectedLabelColor: Colors.grey,
      tabAlignment: TabAlignment.start,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.primaryColor,
    ),

    // 🛒 تصميم بطاقات المنتجات (Cards)
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
// Kareem@123
