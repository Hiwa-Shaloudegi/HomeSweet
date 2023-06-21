import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweet_home/utils/extensions.dart';

class SignupFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatPasswordTextController = TextEditingController();

  String username = '';
  String password = '';
  String repeatPassword = '';
  String role = '';
  String roleGroupValue = 'مدیر';

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
    password = passwordTextController.text.trim().hash;
  }

  void Function(String?)? roleGroupValueOnChanged(String? newValue) {
    roleGroupValue = newValue!;
    update();
    return null;
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  bool repeatPasswordNotMatch() {
    return passwordTextController.text.trim().hash !=
        repeatPasswordTextController.text.trim().hash;
  }

  void saveUserInputs() {
    formKey.currentState!.save();
    role = roleGroupValue;
  }

  void resetForm() {
    formKey.currentState!.reset();
  }
}
