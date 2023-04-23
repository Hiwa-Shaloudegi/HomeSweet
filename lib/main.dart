import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_sweet/routes/pages.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/themes/app_theme.dart';

import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  // await GetStorage.init(); // Initialize GetStorage
  // bool isFirstTime = GetStorage().read<bool>('first_time') ?? true;
  // runApp(MyApp(isFirstTime: isFirstTime));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AMS',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode:
          _themeController.switchValue ? ThemeMode.light : ThemeMode.dark,
      initialRoute: AppRoutes.loginScreen,
      getPages: AppPages.getPages,
    );
  }
}
