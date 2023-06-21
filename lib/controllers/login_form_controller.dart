import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String username = '';
  String password = '';

  bool isPasswordVisible = false;

  // @override
  // void onClose() {
  //   super.onClose();
  //   usernameTextController.clear();
  //   passwordTextController.clear();
  // }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void usernameOnSaved(String? newValue) {
    username = usernameTextController.text.trim();
  }

  void passwordOnSaved(String? newValue) {
    password = passwordTextController.text.trim();
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  void saveUserInputs() {
    formKey.currentState!.save();
  }

  void resetForm() {
    formKey.currentState!.reset();
  }
}
