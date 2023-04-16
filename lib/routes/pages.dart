import 'package:get/get.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/screens/auth/login/login_screen.dart';
import 'package:home_sweet/screens/auth/singup/signup_screen.dart';
import 'package:home_sweet/screens/home/home_screen.dart';

class AppPages {
  AppPages._();
  static final List<GetPage> getPages = [
    GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
  ];
}
