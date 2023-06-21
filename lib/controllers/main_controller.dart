import 'package:get/get.dart';
import 'package:sweet_home/controllers/auth_controller.dart';

class MainController extends GetxController {
  // Controllers
  var authController = Get.find<AuthController>();

  // States
  int currentIndex = 1;

  void selectTab(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }
}
