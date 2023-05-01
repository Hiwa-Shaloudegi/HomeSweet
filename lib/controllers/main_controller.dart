import 'package:get/get.dart';
import 'package:home_sweet/controllers/auth_controller.dart';

class MainController extends GetxController {
  // Controllers
  var authController = Get.find<AuthController>();

  // States
  int currenIndex = 1;

  void selectTab(int selectedIndex) {
    currenIndex = selectedIndex;
    update();
  }
}
