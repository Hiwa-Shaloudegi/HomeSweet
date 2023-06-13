import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/signup_form_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/save_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

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
              key: authController.signupFormController.formKey,
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
                      'ساخت حساب کاربری \nمدیر',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: authController
                          .signupFormController.usernameTextController,
                      hintText: 'نام کاربری',
                      validator: (value) => Validators.usernameValidator(value),
                      onSaved: (newValue) => authController.signupFormController
                          .usernameOnSaved(newValue),
                    ),
                    GetBuilder<SignupFormController>(
                        builder: (signupFormController) {
                      return CustomTextField.password(
                        controller: signupFormController.passwordTextController,
                        obscureText: !signupFormController.isPasswordVisible,
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              signupFormController.togglePasswordVisibility(),
                          child: signupFormController.isPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        validator: (value) =>
                            Validators.passwordValidator(value),
                        onSaved: (newValue) =>
                            signupFormController.passwordOnSaved(newValue),
                      );
                    }),
                    GetBuilder<SignupFormController>(
                        builder: (signupFormController) {
                      return CustomTextField.repeatPassword(
                        controller:
                            signupFormController.repeatPasswordTextController,
                        obscureText:
                            !signupFormController.isRepeatPasswordVisible,
                        suffixIcon: GestureDetector(
                          onTap: () => signupFormController
                              .toggleRepeatPasswordVisibility(),
                          child: signupFormController.isRepeatPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        validator: (value) =>
                            Validators.passwordValidator(value),
                        onSaved: (newValue) {},
                      );
                    }),
                    const SizedBox(height: 16),
                    _goToLoginScreenSection(context),
                    const SizedBox(height: 50),
                    SaveButton(
                      text: 'ثبت نام',
                      onPressed: () => authController.signup(),
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
                    Get.offAndToNamed(AppRoutes.loginScreen);
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
