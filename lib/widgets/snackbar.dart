import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  AppSnackbar._();

  static SnackbarController errorSnackbar(
    String message, {
    String title = 'خطا!',
  }) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withAlpha(220),
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      shouldIconPulse: false,
    );
  }

  static SnackbarController successSnackbar(
    String message, {
    String title = 'تبریک!',
  }) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.withAlpha(220),
      colorText: Colors.white,
    );
  }
}
