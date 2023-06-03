import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';

class AppSnackbar {
  AppSnackbar._();

  static SnackbarController errorSnackbar(
    String message, {
    String title = 'خطا!',
    String? buttonText,
    void Function()? onTap,
  }) {
    assert(buttonText == null && onTap == null ||
        buttonText != null && onTap != null);
    return Get.snackbar(
      title,
      '',
      backgroundColor: Colors.red.withAlpha(220),
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      shouldIconPulse: false,
      messageText: Stack(
        children: [
          SizedBox(
            height: buttonText == null ? 32 : 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Visibility(
            visible: buttonText == null ? false : true,
            child: Positioned(
              right: 0,
              top: 20,
              bottom: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  buttonText ?? '',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
