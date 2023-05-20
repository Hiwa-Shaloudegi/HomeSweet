import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showAppDialog({
  required String title,
  required String message,
  required String textConfirm,
  required String textCancel,
  required void Function()? onConfirm,
}) {
  return Get.defaultDialog(
    titlePadding: const EdgeInsets.only(top: 16, bottom: 8),
    contentPadding: const EdgeInsets.only(bottom: 16),
    title: title,
    middleText: message,
    textConfirm: textCancel,
    textCancel: textConfirm,
    confirmTextColor: Colors.white,
    onCancel: onConfirm,
    onConfirm: () => Get.back(),
  );
}
