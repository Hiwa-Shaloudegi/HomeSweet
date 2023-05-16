import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class CountIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const CountIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  const CountIconButton.add({
    super.key,
    required this.onPressed,
    this.icon = const Icon(Icons.add),
  });
  const CountIconButton.minus({
    super.key,
    required this.onPressed,
    this.icon = const Icon(Icons.remove),
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      color: AppColors.primaryColor,
      iconSize: 18,
      splashRadius: 15,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: icon,
    );
  }
}
