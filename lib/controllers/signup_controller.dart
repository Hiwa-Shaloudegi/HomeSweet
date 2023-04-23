import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/widgets/snackbar.dart';

import '../database/db_helper.dart';
import '../models/user.dart';
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

  late DatabaseHelper databaseHelper;
  var db;
  @override
  void onInit() {
    super.onInit();
    databaseHelper = DatabaseHelper.instance;
  }

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
  }

  void passwordOnSaved(String? newValue) {
    password = passwordTextController.text;
  }

  void signup() async {
    if (formKey.currentState!.validate()) {
      if (passwordTextController.text != repeatPasswordTextController.text) {
        AppSnackbar.errorSnackbar('رمز عبور مطابقت ندارد.');
      } else {
        // input values will be saved in the specified variables.
        formKey.currentState!.save();

        // Save datas to Database
        var user = User(username: username, password: password);
        try {
          await databaseHelper.createUser(user);

          // Transition to the home page
          Get.offAndToNamed(AppRoutes.loginScreen);
          AppSnackbar.successSnackbar('حساب کاربری با موفقیت ساخته شد.');
        } catch (e) {
          print('CATCH ERROR: $e');
        }
      }
    }
  }
}
