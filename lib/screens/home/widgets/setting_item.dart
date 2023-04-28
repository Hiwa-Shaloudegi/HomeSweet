import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.trailing,
    this.textColor,
    // const Icon(
    //   Icons.arrow_back_ios_rounded,
    //   size: 18,
    //   color: AppColors.lightGrey,
    //   textDirection: TextDirection.ltr,
    // ),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      textColor: textColor ?? AppColors.lightGrey,
      iconColor: iconColor ?? AppColors.lightGrey,
      leading: icon,
      title: Text(
        title,
        style: textTheme.titleMedium?.copyWith(color: textColor),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: AppColors.lightGrey,
            textDirection: TextDirection.ltr,
          ),
      onTap: onTap,
    );
  }
}
