import 'package:get/get.dart';
import 'package:home_sweet/database/db_helper.dart';
import 'package:home_sweet/models/user.dart';

class HomeController extends GetxController {
  User? user = User();

  late DatabaseHelper databaseHelper;
  @override
  void onInit() async {
    super.onInit();
    databaseHelper = DatabaseHelper.instance;
    // user = await databaseHelper.getUser(1);
    user = await databaseHelper.getUserByUsername('Hiwa Shaloudegi');
    update();
  }
}
