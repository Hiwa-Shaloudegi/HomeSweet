import 'package:get/get.dart';

import '../themes/app_theme.dart';

class ThemeController extends GetxController {
  bool switchValue = true;

  void onChanged(bool value) {
    switchValue = value;
    Get.changeTheme(
      switchValue ? AppTheme.lightTheme() : AppTheme.darkTheme(),
    );
    update();
  }

  // void toggleTheme() {
  //   Get.changeTheme(
  //     Get.isDarkMode ? AppTheme.theme() : AppTheme.darkTheme(),
  //   );
  // }
}
