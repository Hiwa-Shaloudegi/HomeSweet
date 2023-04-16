import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String username = '';
  String password = '';
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
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
      formKey.currentState!.save();
      print('SUBMIT FORM: $username, $password');
    }
  }
}
