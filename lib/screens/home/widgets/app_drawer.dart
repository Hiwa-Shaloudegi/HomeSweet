import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/theme_controller.dart';

import '../../../constants/colors.dart';
import '../../../controllers/login_controller.dart';
import '../../../my_custom_icon_icons.dart';
import '../home_screen.dart';

class SettingDrawer extends StatelessWidget {
  SettingDrawer({super.key});

  final themeController = Get.put(ThemeController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              _header(textTheme),
              const SizedBox(height: 30),
              _profileSection(textTheme),
              const SizedBox(height: 24),
              ...itemsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileSection(TextTheme textTheme) {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            // color: Colors.grey,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/manager.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'کیان صداقتی',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'مدیر ساختمان',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _header(TextTheme textTheme) {
    return Row(
      children: [
        //? How to center the text.
        const SizedBox(width: 55),
        const Spacer(),
        Text(
          'تنظیمات',
          style: textTheme.titleLarge,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 22,
            color: AppColors.lightGrey,
            textDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }

  List itemsList() {
    return [
      SettingItem(
        title: 'حساب کاربری',
        icon: const Icon(MyCustomIcon.profile),
        onTap: () {},
      ),
      SettingItem(
        title: 'تم اپلیکیشن',
        icon: const Icon(Icons.edit_outlined),
        onTap: () {},
      ),
      SettingItem(
        title: 'حالت روز',
        icon: const Icon(Icons.wb_sunny_outlined),
        trailing: Switch.adaptive(
          value: themeController.switchValue,
          onChanged: (value) => themeController.onChanged(value),
        ),
        onTap: () {},
      ),
      const Divider(
        color: AppColors.dividerColor,
        thickness: 1,
        indent: 32,
        endIndent: 32,
      ),
      SettingItem(
        title: 'درباره ما',
        icon: const Icon(MyCustomIcon.aboutCircle),
        onTap: () {},
      ),
      SettingItem(
        title: 'سوالات پرتکرار',
        icon: const Icon(Icons.question_answer_outlined),
        onTap: () {},
      ),
      SettingItem(
        title: 'دفترچه راهنما',
        icon: const Icon(Icons.help_outline_rounded,
            textDirection: TextDirection.ltr),
        onTap: () {},
      ),
      SettingItem(
        title: 'خروج از حساب کاربری',
        icon: const Icon(Icons.logout_rounded, color: Colors.red),
        textColor: Colors.red,
        trailing: const SizedBox.shrink(),
        onTap: () {
          loginController.logout();
        },
      ),
    ];
  }
}
