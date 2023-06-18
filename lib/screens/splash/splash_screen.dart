import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/controllers/auth_controller.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1800)).then(
      (value) => Get.find<AuthController>().isUserLoggedIn
          ? Get.toNamed(AppRoutes.mainScreen)
          : Get.toNamed(
              AppRoutes.loginScreen,
            ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/Home.json',
              width: 250,
              repeat: false,
            ),
            const SizedBox(height: 16),
            const Text(
              'صابخونه...',
              style: TextStyle(
                fontFamily: 'ghasem',
                fontSize: 50,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
