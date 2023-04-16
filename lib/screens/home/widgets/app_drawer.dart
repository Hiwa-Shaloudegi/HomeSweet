import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/theme_controller.dart';

import '../../../constants/colors.dart';
import '../../../my_custom_icon_icons.dart';
import '../home_screen.dart';

class SettingDrawer extends StatelessWidget {
  SettingDrawer({super.key});

  static const Map<String, dynamic> settingItems = {
    'حساب کاربری': Icon(MyCustomIcon.profile),
    'تم اپلیکیشن': Icon(Icons.edit_outlined),
    'حالت روز': Icon(Icons.wb_sunny_outlined),
    'درباره ما': Icon(MyCustomIcon.aboutCircle),
    'سوالات پرتکرار': Icon(
        Icons.question_answer_outlined), //Icon(MyCustomIcon.messageQuestion),
    'دفترچه راهنما': Icon(Icons.help_outline_rounded,
        textDirection: TextDirection.ltr), //Icon(MyCustomIcon.help),
    'خروج از حساب کاربری': Icon(Icons.logout_rounded),
  };

  var settingItemList = settingItems.entries.toList();

  final themeController = Get.put(ThemeController());

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
              Expanded(
                // TODO: Come up with a better solution.
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: settingItemList.length,
                  itemBuilder: (context, index) {
                    late Widget? trailing;
                    if (index == settingItemList.length - 1) {
                      trailing = const SizedBox.shrink();
                    } else if (index == 2) {
                      trailing = GetBuilder<ThemeController>(
                          builder: (themeController) {
                        return Switch.adaptive(
                          value: themeController.switchValue,
                          onChanged: (value) =>
                              themeController.onChanged(value),
                        );
                      });
                    } else {
                      trailing = null; // use default widget.
                    }
                    return SettingItem(
                      title: settingItemList[index].key,
                      icon: settingItemList[index].value,
                      iconColor: index == settingItemList.length - 1
                          ? Colors.red
                          : null,
                      textColor: index == settingItemList.length - 1
                          ? Colors.red
                          : null,
                      trailing: trailing,
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (context, index) {
                    return index == 2
                        ? const Divider(
                            color: AppColors.dividerColor,
                            thickness: 1,
                            indent: 32,
                            endIndent: 32,
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
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
}
