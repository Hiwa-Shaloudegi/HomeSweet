import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_sweet/routes/pages.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/themes/app_theme.dart';

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
      theme: AppTheme.themeData(),
      initialRoute: AppRoutes.homeScreen,
      getPages: AppPages.getPages,
    );
  }
}
