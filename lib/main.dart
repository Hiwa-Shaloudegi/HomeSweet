import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_sweet/constants/storage_keys.dart';
import 'package:home_sweet/models/user.dart';
import 'package:home_sweet/routes/pages.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await GetStorage.init();
  // bool isFirstTime = GetStorage().read<bool>('first_time') ?? true;
  // runApp(MyApp(isFirstTime: isFirstTime));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    var userMap = box.read(StorageKeys.user);
    bool isUserLoggedIn = userMap == null ? false : true;

    return GetMaterialApp(
      title: 'AMS',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode:
          _themeController.switchValue ? ThemeMode.light : ThemeMode.dark,
      initialRoute:
          isUserLoggedIn ? AppRoutes.homeScreen : AppRoutes.signUpScreen,
      getPages: AppPages.getPages,
    );
  }
}
