import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_sweet/controllers/apartment_form_controller.dart';
import 'package:home_sweet/controllers/login_form_controller.dart';
import 'package:home_sweet/controllers/main_controller.dart';
import 'package:home_sweet/controllers/signup_form_controller.dart';

import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';
import 'themes/app_theme.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await GetStorage.init();
  // TODO: Checking if the app is launched for the first time. If yes then show the onBording screen.
  // bool isFirstTime = GetStorage().read<bool>('first_time') ?? true;
  // runApp(MyApp(isFirstTime: isFirstTime));
  Get.put(ApartmentFormController());
  Get.put(LoginFormController());
  Get.put(SignupFormController());
  Get.put(AuthController());
  Get.put(MainController());
}

void main() async {
  await initApp();
  runApp(TheApp());
}

class TheApp extends StatelessWidget {
  TheApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    // var box = GetStorage();
    // var userMap = box.read(StorageKeys.user);
    // bool isUserLoggedIn = userMap == null ? false : true;
    var authController = Get.find<AuthController>();

    return GetMaterialApp(
      title: 'AMS',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode:
          _themeController.switchValue ? ThemeMode.light : ThemeMode.dark,
      initialRoute: authController.isUserLoggedIn
          ? AppRoutes.mainScreen
          : AppRoutes.signUpScreen,
      getPages: AppPages.getPages,
    );
  }
}
