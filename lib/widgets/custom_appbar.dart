import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controllers/main_controller.dart';
import '../my_custom_icon_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final mainController = Get.find<MainController>();

  CustomAppBar({
    super.key,
  });

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
        return Row(
          children: [
            _menu(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: username(),
            ),
            const SizedBox(width: 8),
            _profilePicture(),
          ],
        );
      }),
    );
  }

  Widget username() {
    return Builder(builder: (context) {
      var textTheme = Theme.of(context).textTheme;

      return Column(
        children: [
          Text(
            mainController.authController.loggedInUser!.username ??
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
    });
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
