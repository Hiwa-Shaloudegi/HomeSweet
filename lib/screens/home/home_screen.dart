import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/controllers/home_controller.dart';
import 'package:home_sweet/controllers/login_controller.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/navbar.dart';
import 'widgets/app_drawer.dart';
import 'widgets/management_item.dart';

class HomeScreen extends StatelessWidget {
  var homeController = Get.put(HomeController());
  var loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      drawer: SettingDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Container(
                  // color: Colors.amber,
                  height: 400,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 180,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return ManagementItem(index: index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

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
