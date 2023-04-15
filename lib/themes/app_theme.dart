import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData() {
    return ThemeData(
      fontFamily: 'iransans',
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      primaryColor: AppColors.primaryColor,
      iconTheme: const IconThemeData(),
      textTheme: textTheme(),
      elevatedButtonTheme: elevatedButtonTheme(),
      inputDecorationTheme: inputDecorationTheme(),
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffE0E5ED),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 2,
        ),
      ),
      fillColor: const Color(0xffF6F7F9),
      hintStyle: const TextStyle(
        color: Color(0xffA9B0C5),
        fontSize: 16,
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(AppColors.primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // overlayColor: MaterialStatePropertyAll(AppColors.primaryColor),
      ),
    );
  }

  static TextTheme textTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: Color(0xff767E8C),
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: AppColors.lightGrey,
        fontSize: 16,
      ),
    );
  }
}
