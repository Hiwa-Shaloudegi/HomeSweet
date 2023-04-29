import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/navbar.dart';
import 'home_nav_item.dart';
import 'widgets/app_drawer.dart';

class MainScreen extends StatelessWidget {
  final mainController = Get.put(MainController());

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
            child: GetBuilder<MainController>(
              builder: (mainController) {
                return IndexedStack(
                  index: mainController.currenIndex,
                  children: [
                    Text('PROFILE'),
                    HomeNavItem(),
                    Text('Apartment'),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
