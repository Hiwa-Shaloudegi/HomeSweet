import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/utils/extensions.dart';

class SignupFormController extends GetxController {
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
    username = usernameTextController.text.trim();
  }

  void passwordOnSaved(String? newValue) {
    password = passwordTextController.text.trim().hash();
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  bool repeatPasswordNotMatch() {
    return passwordTextController.text.trim().hash() !=
        repeatPasswordTextController.text.trim().hash();
  }

  void saveUserInputs() {
    formKey.currentState!.save();
  }

  void resetForm() {
    formKey.currentState!.reset();
  }
}
