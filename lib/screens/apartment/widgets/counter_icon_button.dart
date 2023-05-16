import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class CounteIconButton extends StatelessWidget {
  final Icon icon;
  const CounteIconButton({
    super.key,
    required this.icon,
  });

  const CounteIconButton.add({super.key, this.icon = const Icon(Icons.add)});
  const CounteIconButton.minus(
      {super.key, this.icon = const Icon(Icons.minimize_outlined)});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      color: AppColors.primaryColor,
      iconSize: 18,
      splashRadius: 15,
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(),
      icon: icon,
    );
  }
}
