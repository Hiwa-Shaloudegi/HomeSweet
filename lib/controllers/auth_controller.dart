import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_sweet/controllers/staff_controller.dart';
import 'package:home_sweet/database/apartment_repository.dart';
import 'package:home_sweet/database/staff_repository.dart';
import 'package:home_sweet/models/staff.dart';

import '../constants/storage_keys.dart';
import '../widgets/snackbar.dart';
import '../database/db_helper.dart';
import '../routes/routes.dart';
import 'login_form_controller.dart';
import 'signup_form_controller.dart';

class AuthController extends GetxController {
  // Controllers
  final staffController = Get.put(StaffController());
  final signupFormController = Get.find<SignupFormController>();
  final loginFormController = Get.find<LoginFormController>();

  // States
  bool isUserLoggedIn = false;
  Staff? loggedInUser;

  late DatabaseHelper databaseHelper;
  var box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    databaseHelper = DatabaseHelper.instance;
    //!!!
    var userMap = box.read(StorageKeys.user);

    if (userMap != null) {
      loggedInUser = Staff.fromMap(userMap);
      isUserLoggedIn = true;
    } else {
      loggedInUser = null;
      isUserLoggedIn = false;
    }

    // TODO: use 'ever' for changing [isUserLoggedIn] whenever [loggedInUser] changes.
    // ever(loggedInUser, (callback) => );
  }

  void signup() async {
    if (signupFormController.validate()) {
      if (signupFormController.repeatPasswordNotMatch()) {
        AppSnackbar.errorSnackbar('رمز عبور مطابقت ندارد.');
      } else {
        signupFormController.saveUserInputs();

        if (await StaffRepository.isUsernameTaken(
            signupFormController.username)) {
          AppSnackbar.errorSnackbar('این نام کاربری قبلا انتخاب شده است.');
          return;
        }

        // Save datas to Database

        var staff = Staff(
          username: signupFormController.username,
          password: signupFormController.password,
          firstName: null,
          lastName: null,
          role: signupFormController.role,
          salary: null,
          staffPhoneNumber: null,
          startingDate: null,
        );
        //!!!
        signupFormController.resetForm();

        try {
          await StaffRepository.create(staff);

          // Transition to the home page
          Get.offAndToNamed(AppRoutes.loginScreen);
          AppSnackbar.successSnackbar('حساب کاربری با موفقیت ساخته شد.');
        } catch (e) {
          throw Exception('CATCH ERROR: $e');
        }
      }
    }
  }

  void login() async {
    if (loginFormController.validate()) {
      loginFormController.saveUserInputs();

      try {
        loggedInUser = await StaffRepository.getLoginUser(
          loginFormController.username,
          loginFormController.password,
        );
        //! using ever
        isUserLoggedIn = true;

        if (loggedInUser != null) {
          loginFormController.resetForm();

          // Managing logged-in user session
          var box = GetStorage();
          await box.write(StorageKeys.user, loggedInUser!.toMap());

          // Transition to the homePage OR apartmentFormPage
          var apartment = await ApartmentRepository.read(1);
          if (apartment != null) {
            Get.offAndToNamed(AppRoutes.mainScreen);
            AppSnackbar.successSnackbar('شما با موفقیت وارد شدید.');
          } else {
            Get.offAndToNamed(AppRoutes.apartmentFormPage);
          }
        } else {
          AppSnackbar.errorSnackbar('نام کاربری یا رمز عبور اشتباه می باشد.');
        }
      } catch (e) {
        throw Exception("ERROR: $e");
      }
    }

    update();
  }

  void logout() async {
    var box = GetStorage();
    await box.remove(StorageKeys.user);
    loggedInUser = null;
    //! using ever
    isUserLoggedIn = false;
    update();
    //!
    Get.offNamed(AppRoutes.loginScreen);
  }
}
