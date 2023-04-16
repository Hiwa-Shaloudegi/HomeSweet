import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatPasswordTextController = TextEditingController();

  String username = '';
  String password = '';
  String repeatPassword = '';
  bool isPasswordVisible = false;
  bool isRepeatPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleRepeatPasswordVisibility() {
    isRepeatPasswordVisible = !isRepeatPasswordVisible;
    update();
  }

  void usernameOnSaved(String? newValue) {
    username = usernameTextController.text;
    print('USERNAME: $username');
  }

  void passwordOnSaved(String? newValue) {
    password = passwordTextController.text;
    print('PASSWORD: $password');
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      if (passwordTextController.text != repeatPasswordTextController.text) {
        Get.snackbar(
          'خطا!',
          'رمز عبور مطابقت ندارد.',
          backgroundColor: Colors.red.withAlpha(220),
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white),
          shouldIconPulse: false,
        );
      } else {
        formKey.currentState!.save();

        Get.offAndToNamed(AppRoutes.homeScreen);
        Get.snackbar(
          'تبریک!',
          'شما با موفقیت وارد شدید.',
          backgroundColor: Colors.green.withAlpha(220),
          colorText: Colors.white,
        );
      }
      print('SUBMIT FORM: $username, $password');
    }
  }
}
