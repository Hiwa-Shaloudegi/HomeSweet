import 'package:get/get.dart';
import 'package:home_sweet/screens/home/main_screen.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/singup/signup_screen.dart';
import 'routes.dart';

class AppPages {
  AppPages._();
  static final List<GetPage> getPages = [
    GetPage(name: AppRoutes.mainScreen, page: () => MainScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
  ];
}
