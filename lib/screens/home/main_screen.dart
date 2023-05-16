import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/screens/apartment/apartment_form_page.dart';

import '../../controllers/main_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/navbar.dart';
import 'home_nav_item.dart';
import 'widgets/app_drawer.dart';

class MainScreen extends StatelessWidget {
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (mainController) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainController.currenIndex == 2 ? null : CustomAppBar(),
        drawer: SettingDrawer(),
        body: _buildPageBody(mainController.currenIndex),
        // SafeArea(
        //   child: SingleChildScrollView(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: IndexedStack(
        //         index: mainController.currenIndex,
        //         children: [
        //           Text('PROFILE'),
        //           HomeNavItem(),
        //           ApartmentFormPage(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }

  Widget _buildPageBody(int index) {
    switch (index) {
      case 0:
        return Container();
      case 1:
        return HomeNavItem();
      case 2:
        return ApartmentFormPage();
      default:
        return Container();
    }
  }
}
