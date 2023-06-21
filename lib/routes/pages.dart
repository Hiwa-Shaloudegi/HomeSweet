import 'package:get/get.dart';
import 'package:sweet_home/screens/apartment/apartment_form_page.dart';
import 'package:sweet_home/screens/charge/charge_page.dart';
import 'package:sweet_home/screens/costs/costs_page.dart';
import 'package:sweet_home/screens/home/main_screen.dart';
import 'package:sweet_home/screens/splash/splash_screen.dart';
import 'package:sweet_home/screens/staff/staff_page.dart';
import 'package:sweet_home/screens/units/unit_page.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/singup/signup_screen.dart';
import 'routes.dart';

class AppPages {
  AppPages._();
  static final List<GetPage> getPages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.mainScreen, page: () => MainScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.apartmentFormPage, page: () => ApartmentFormPage()),
    GetPage(name: AppRoutes.costsPage, page: () => CostsPage()),
    GetPage(name: AppRoutes.unitPage, page: () => UnitPage()),
    GetPage(name: AppRoutes.chargePage, page: () => ChargePage()),
    GetPage(name: AppRoutes.staffPage, page: () => const StaffPage()),
  ];
}
