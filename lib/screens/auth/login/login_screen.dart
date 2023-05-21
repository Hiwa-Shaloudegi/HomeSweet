import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/login_form_controller.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/save_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Controllers
  final authController = Get.find<AuthController>();

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: authController.loginFormController.formKey,
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: authController
                        .loginFormController.usernameTextController,
                    hintText: 'نام کاربری',
                    validator: (value) => Validators.usernameValidator(value),
                    onSaved: (newValue) => authController.loginFormController
                        .usernameOnSaved(newValue),
                  ),
                  GetBuilder<LoginFormController>(
                      builder: (loginFormController) {
                    return CustomTextField.password(
                      controller: loginFormController.passwordTextController,
                      obscureText: !loginFormController.isPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            loginFormController.togglePasswordVisibility(),
                        child: loginFormController.isPasswordVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      validator: (value) => Validators.passwordValidator(value),
                      onSaved: (newValue) =>
                          loginFormController.passwordOnSaved(newValue),
                    );
                  }),
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
                    onPressed: () => authController.login(),
                  ),
                ],
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
        Get.offAndToNamed(AppRoutes.signUpScreen);
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
