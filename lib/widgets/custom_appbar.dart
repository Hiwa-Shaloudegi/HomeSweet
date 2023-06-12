import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/auth_controller.dart';
import 'package:home_sweet/controllers/staff_controller.dart';

import '../constants/colors.dart';
import '../controllers/main_controller.dart';
import '../my_custom_icon_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});

  final mainController = Get.find<MainController>();

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 150,
      title: GetBuilder<MainController>(builder: (mainController) {
        return GetBuilder<AuthController>(builder: (authController) {
          return Row(
            children: [
              _menu(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Username(),
              ),
              const SizedBox(width: 8),
              _profilePicture(),
            ],
          );
        });
      }),
    );
  }

  Widget _menu() {
    return Builder(
      builder: (context) => IconButton(
        iconSize: 42,
        icon: const Icon(
          MyCustomIcon.menu,
          color: AppColors.primaryColor,
        ),
        splashColor: AppColors.primaryColor.withOpacity(0.1),
        highlightColor: AppColors.primaryColor.withOpacity(0.1),
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  Widget _profilePicture() {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        // color: Colors.grey,
        shape: BoxShape.circle,
        image: const DecorationImage(
          image: AssetImage('assets/images/manager.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 3),
            blurRadius: 2,
          ),
        ],
      ),
    );
  }
}

class Username extends StatelessWidget {
  Username({super.key});

  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<StaffController>(builder: (staffController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            authController.loggedInUser!.firstName != null
                ? SizedBox(
                    width: 164,
                    child: Text(
                      '${authController.loggedInUser!.firstName} ${authController.loggedInUser!.lastName}',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.left,
                    ),
                  )
                : GestureDetector(
                    onTap: () {},
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
              authController.loggedInUser!.role == 'manager'
                  ? 'مدیر ساختمان'
                  : 'لابی من',
              style: textTheme.bodySmall,
            ),
          ],
        );
      });
    });
  }
}
