import 'package:get/get.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/singup/signup_screen.dart';
import '../screens/home/home_screen.dart';
import 'routes.dart';

class AppPages {
  AppPages._();
  static final List<GetPage> getPages = [
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
  ];
}
