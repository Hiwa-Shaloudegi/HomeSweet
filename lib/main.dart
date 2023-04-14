import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/singup/signup_screen.dart';
import 'package:home_sweet/screens/home/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AMS',
      debugShowCheckedModeBanner: false,

      locale: const Locale('fa'),

      theme: ThemeData(
        fontFamily: 'iransans',
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        primaryColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(),
        textTheme: const TextTheme(
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
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            // overlayColor: MaterialStatePropertyAll(AppColors.primaryColor),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
        ),
      ),
      home: const SignUpScreen(), //const HomeScreen(),
    );
  }
}
