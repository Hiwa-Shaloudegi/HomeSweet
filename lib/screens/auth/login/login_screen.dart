import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/utils/validators.dart';

import '../../../controllers/login_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/save_button.dart';

class LoginScreen extends StatelessWidget {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: loginController.formKey,
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
                    CustomTextField(
                      controller: loginController.usernameTextController,
                      hintText: 'نام کاربری',
                      validator: (value) => Validators.usernameValidator(value),
                      onSaved: (newValue) =>
                          loginController.usernameOnSaved(newValue),
                    ),
                    GetBuilder<LoginController>(builder: (loginController) {
                      return CustomTextField.password(
                        controller: loginController.passwordTextController,
                        obscureText: !loginController.isPasswordVisible,
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              loginController.togglePasswordVisibility(),
                          child: loginController.isPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                        validator: (value) =>
                            Validators.passwordValidator(value),
                        onSaved: (newValue) =>
                            loginController.passwordOnSaved(newValue),
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
                      onPressed: () => loginController.submitForm(),
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
