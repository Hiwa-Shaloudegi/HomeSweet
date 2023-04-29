import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/storage_keys.dart';
import '../database/user_repository.dart';
import '../models/user.dart';

class MainController extends GetxController {
  User? user = User();
  int currenIndex = 1;

  var box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    getLoggedInUser();
  }

  void getLoggedInUser() async {
    var loggedInUser = box.read(StorageKeys.user);

    user = await UserRepository.read(loggedInUser['_id']);
    update();
  }

  void selectTab(int selectedIndex) {
    currenIndex = selectedIndex;
    update();
  }
}
