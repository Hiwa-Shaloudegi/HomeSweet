import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/staff_controller.dart';

import '../../../constants/colors.dart';
import '../../../controllers/main_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../my_custom_icon_icons.dart';
import '../../../routes/routes.dart';
import '../../../widgets/app_dialog.dart';
import '../../staff/widgets/staff_bottomsheet.dart';
import 'setting_item.dart';

class SettingDrawer extends StatelessWidget {
  SettingDrawer({super.key});

  // Controllers
  final themeController = Get.put(ThemeController());
  final staffController = Get.find<StaffController>();
  final mainController = Get.find<MainController>();

  // UI
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
    return Builder(builder: (context) {
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
          // Text(
          //   mainController.authController.loggedInUser!.username ?? 'کیان صداقتی',
          //   style: textTheme.bodyLarge,
          // ),
          mainController.authController.loggedInUser!.firstName != null
              ? SizedBox(
                  width: Get.width * 0.7,
                  child: Text(
                    '${mainController.authController.loggedInUser!.firstName} ${mainController.authController.loggedInUser!.lastName}',
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    Get.toNamed(AppRoutes.staffPage);

                    staffController.staffToUpdate =
                        mainController.authController.loggedInUser;
                    staffController.loadSelectedStaffData();

                    await showStaffFormBottomSheet(context).then(
                      (value) => staffController.resetForm(),
                    );
                  },
                  child: const Text(
                    'تکمیل پروفایل',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ),
          const SizedBox(height: 8),
          Text(
            mainController.authController.loggedInUser!.role == 'manager'
                ? 'مدیر ساختمان'
                : 'لابی من',
            style: textTheme.bodySmall,
          ),
        ],
      );
    });
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
          showAppDialog(
            title: 'اطلاع',
            message:
                'آیا مطمئن هستید که می خواهید از حساب کاربری خود خارج شوید؟',
            textConfirm: 'بلی',
            textCancel: 'خیر',
            onConfirm: () => mainController.authController.logout(),
          );
        },
      ),
    ];
  }
}
