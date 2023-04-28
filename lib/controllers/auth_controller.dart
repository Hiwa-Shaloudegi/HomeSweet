import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/storage_keys.dart';
import '../database/user_repository.dart';
import '../widgets/snackbar.dart';
import '../database/db_helper.dart';
import '../models/user.dart';
import '../routes/routes.dart';
import 'login_form_controller.dart';
import 'signup_form_controller.dart';

class AuthController extends GetxController {
  // Controllers
  final signupFormController = Get.find<SignupFormController>();
  final loginFormController = Get.find<LoginFormController>();

  late DatabaseHelper databaseHelper;
  @override
  void onInit() {
    super.onInit();
    databaseHelper = DatabaseHelper.instance;
  }

  void signup() async {
    if (signupFormController.validate()) {
      if (signupFormController.repeatPasswordNotMatch()) {
        AppSnackbar.errorSnackbar('رمز عبور مطابقت ندارد.');
      } else {
        signupFormController.saveUserInputs();

        // Save datas to Database
        var user = User(
          username: signupFormController.username,
          password: signupFormController.password,
        );
        signupFormController.resetForm();

        try {
          await UserRepository.create(user);

          // Transition to the home page
          Get.offAndToNamed(AppRoutes.loginScreen);
          AppSnackbar.successSnackbar('حساب کاربری با موفقیت ساخته شد.');
        } catch (e) {
          print('CATCH ERROR: $e');
        }
      }
    }
  }

  void login() async {
    if (loginFormController.validate()) {
      loginFormController.saveUserInputs();

      try {
        User? user = await databaseHelper.getLoginUser(
          loginFormController.username,
          loginFormController.password,
        );
        loginFormController.resetForm();

        if (user != null) {
          // Managing logged-in user session
          var box = GetStorage();
          await box.write(StorageKeys.user, user.toMap());

          // Transition to the home page
          Get.offAndToNamed(AppRoutes.homeScreen);
          AppSnackbar.successSnackbar('شما با موفقیت وارد شدید.');
        } else {
          AppSnackbar.errorSnackbar('نام کاربری یا رمز عبور اشتباه می باشد.');
        }
      } catch (e) {
        print("ERROR: $e");
      }
    }
  }

  void logout() async {
    var box = GetStorage();
    await box.remove(StorageKeys.user);
    Get.offNamed(AppRoutes.loginScreen);
  }
}
