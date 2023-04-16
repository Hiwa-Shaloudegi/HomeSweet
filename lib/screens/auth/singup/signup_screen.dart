import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/controllers/signup_controller.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';
import 'package:home_sweet/utils/validators.dart';

import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: signUpController.formKey,
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
                      CustomTextField(
                        controller: signUpController.usernameTextController,
                        hintText: 'نام کاربری',
                        validator: (value) =>
                            Validators.usernameValidator(value),
                        onSaved: (newValue) =>
                            signUpController.usernameOnSaved(newValue),
                      ),
                      GetBuilder<SignUpController>(builder: (signUpController) {
                        return CustomTextField.password(
                          controller: signUpController.passwordTextController,
                          obscureText: !signUpController.isPasswordVisible,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                signUpController.togglePasswordVisibility(),
                            child: signUpController.isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          validator: (value) =>
                              Validators.passwordValidator(value),
                          onSaved: (newValue) =>
                              signUpController.passwordOnSaved(newValue),
                        );
                      }),
                      GetBuilder<SignUpController>(builder: (signUpController) {
                        return CustomTextField.repeatPassword(
                          controller:
                              signUpController.repeatPasswordTextController,
                          obscureText:
                              !signUpController.isRepeatPasswordVisible,
                          suffixIcon: GestureDetector(
                            onTap: () => signUpController
                                .toggleRepeatPasswordVisibility(),
                            child: signUpController.isRepeatPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          validator: (value) =>
                              Validators.passwordValidator(value),
                          onSaved: (newValue) {},
                        );
                      }),
                      const SizedBox(height: 8),
                      _goToLoginScreenSection(context),
                      const SizedBox(height: 60),
                      SaveButton(
                          text: 'ثبت نام',
                          onPressed: () {
                            signUpController.submitForm();
                          }),
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
