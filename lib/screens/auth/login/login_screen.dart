import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/singup/signup_screen.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/save_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Container(
                // color: Colors.amber,
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Image.asset(
                      'assets/images/app_icon.png',
                      width: 120,
                      height: 110,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ورود به حساب کاربری',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 24),
                    const CustomTextField(hintText: 'نام کاربری'),
                    const CustomTextField.password(),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Color(0xffCACACF),
                      indent: 120,
                      endIndent: 120,
                      thickness: 2,
                      height: 20,
                    ),
                    _goToSignUpScreen(context),
                    const SizedBox(height: 180),
                    SaveButton(
                      text: 'ورود',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _goToSignUpScreen(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(const SignUpScreen());
      },
      child: Text(
        'ساخت حساب کاربری',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
      ),
    );
  }
}
