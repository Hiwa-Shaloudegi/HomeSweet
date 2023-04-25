import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/widgets/snackbar.dart';

import '../database/db_helper.dart';
import '../models/user.dart';
import '../routes/routes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String username = '';
  String password = '';

  bool isPasswordVisible = false;

  late DatabaseHelper databaseHelper;
  @override
  void onInit() {
    super.onInit();
    databaseHelper = DatabaseHelper.instance;
  }

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

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        User? user = await databaseHelper.getLoginUser(username, password);
        if (user != null) {
          // Transition to the home page
          Get.offAndToNamed(AppRoutes.homeScreen);
          AppSnackbar.successSnackbar('شما با موفقیت وارد شدید.');
        } else {
          AppSnackbar.errorSnackbar('نام کاربری یا رمز عبور اشتباه می باشد.');
        }
      } catch (e) {
        print("ERROR: $e");
      }
    }
  }
}
