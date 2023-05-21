import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';

class FormBottomSheetHeader extends StatelessWidget {
  const FormBottomSheetHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.textTheme().headlineLarge,
        ),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
