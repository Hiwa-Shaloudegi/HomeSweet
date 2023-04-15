import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';

import '../login/login_screen.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                child: Center(
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
                        'ساخت حساب کاربری',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const CustomTextField(hintText: 'نام کاربری'),
                      const CustomTextField.password(),
                      const CustomTextField.repeatPassword(),
                      const SizedBox(height: 8),
                      _goToLoginScreenSection(context),
                      const SizedBox(height: 60),
                      SaveButton(
                        text: 'ثبت نام',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _goToLoginScreenSection(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Color(0xffCACACF),
          indent: 120,
          endIndent: 120,
          thickness: 2,
          height: 20,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'حساب کاربری دارید؟',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 14),
              ),
              TextSpan(
                // !NEW
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(const LoginScreen());
                  },
                text: ' ورود',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
