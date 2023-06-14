import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/screens/apartment/apartment_form_page.dart';

import '../../controllers/apartment_form_controller.dart';
import '../../controllers/main_controller.dart';
import '../../controllers/staff_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/navbar.dart';
import 'home_nav_item.dart';
import 'widgets/app_drawer.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final mainController = Get.put(MainController());
  final apartmentFormController = Get.put(ApartmentFormController());
  final staffController = Get.put(StaffController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (mainController) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainController.currentIndex == 2 ? null : CustomAppBar(),
        drawer: SettingDrawer(),
        body: _buildPageBody(mainController.currentIndex),
        bottomNavigationBar: NavBar(),
      ),
    );
  }

  Widget _buildPageBody(int index) {
    switch (index) {
      case 0:
        return Container();
      case 1:
        return const HomeNavItem();
      case 2:
        return apartmentFormBody(); //ApartmentFormPage();
      default:
        return Container();
    }
  }
}
