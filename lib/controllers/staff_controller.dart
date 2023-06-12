import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../database/staff_repository.dart';
import '../models/staff.dart';
import '../routes/routes.dart';
import '../widgets/app_dialog.dart';
import '../widgets/snackbar.dart';

class StaffController extends GetxController {
  // Form
  final formKey = GlobalKey<FormState>();

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final salaryTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var radioGroupValue = 1;

  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String date = '';
  String username = '';
  String password = '';
  int salary = 0;
  String role = 'manager';

  // States
  bool isLoading = true;
  bool isPasswordVisible = false;
  List<Staff> allStaff = [];

  Staff? staffToUpdate = null; //!

  // OnSaved
  void firstNameOnSaved(String? newValue) =>
      firstName = firstNameTextController.text.trim();

  void lastNameOnSaved(String? newValue) =>
      lastName = lastNameTextController.text.trim();

  void phoneNumberOnSaved(String? newValue) =>
      phoneNumber = phoneNumberTextController.text.trim();

  void dateOnSaved(String? newValue) => date = dateTextController.text.trim();

  void usernameOnSaved(String? newValue) =>
      username = usernameTextController.text.trim();

  void passwordOnSaved(String? newValue) =>
      password = passwordTextController.text.trim().hash;

  void salaryOnSaved(String? newValue) =>
      salary = int.parse(salaryTextController.text.trim());

  void Function(int?)? radioOnChanged(value) {
    radioGroupValue = value;
    if (radioGroupValue == 1) {
      role = 'manager';
    } else if (radioGroupValue == 2) {
      role = 'lobby man';
    }
    update();
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  //
  bool validate() => formKey.currentState!.validate();

  void saveStaffInputs() => formKey.currentState!.save();

  void resetForm() {
    formKey.currentState!.reset();
    //! is it necessary?
    firstNameTextController.clear();
    lastNameTextController.clear();
    phoneNumberTextController.clear();
    dateTextController.clear();
    salaryTextController.clear();
    usernameTextController.clear();
    passwordTextController.clear();
    radioGroupValue = 1;
    isPasswordVisible = false;

    role = 'manager';
    firstName = '';
    lastName = '';
    phoneNumber = '';
    date = '';
    username = '';
    password = '';
    salary = 0;

    staffToUpdate = null;
  }

  @override
  void onInit() {
    getAllStaff();
    super.onInit();
  }

  // CRUD
  void getAllStaff() async {
    isLoading = true;
    allStaff.clear();

    allStaff.addAll(await StaffRepository.readAll());
    log(allStaff.toString());

    //Reversing the list to get the recent added items first.
    allStaff = List.from(allStaff.reversed);

    await Future.delayed(const Duration(milliseconds: 350));
    isLoading = false;
    update();
  }

  saveData() async {
    if (validate()) {
      saveStaffInputs();

      if (staffToUpdate == null) {
        createStaff();
      } else {
        updateStaff();
      }
    }

    update();
  }

  createStaff() async {
    Staff newStaff = Staff(
      firstName: firstName,
      lastName: lastName,
      role: role,
      staffPhoneNumber: phoneNumber,
      salary: salary,
      startingDate: date,
      username: username,
      password: password,
    );

    try {
      newStaff = await StaffRepository.create(newStaff);
      allStaff.insert(0, newStaff);

      Get.back();
      AppSnackbar.successSnackbar(
        role == 'manager'
            ? 'اطلاعات مدیر با موفقیت ثبت شد.'
            : 'اطلاعات لابی من با موفقیت ثبت شد.',
      );
      resetForm();
    } catch (e) {
      throw Exception('CATCH ERROR: $e');
    } finally {
      update();
    }
  }

  updateStaff() async {}

  void deleteStaff(int id) async {
    isLoading = true;
    await showAppDialog(
      title: 'هشدار',
      message: 'آیا مطمئن هستید که می خواهید این مورد را حذف کنید؟',
      textConfirm: 'بلی',
      textCancel: 'خیر',
      onConfirm: () async {
        var staffToDelete = await StaffRepository.read(id);
        await StaffRepository.delete(id);

        // Removes any snackbar or dialog on the stack until it gets to the actual screen.
        Navigator.of(Get.overlayContext!)
            .popUntil(ModalRoute.withName(AppRoutes.staffPage));

        // Also removes the staff from list of costs state.
        allStaff.removeWhere((staff) => staff.id == id);
        AppSnackbar.successSnackbar(
          staffToDelete.role == 'manager'
              ? 'اطلاعلات مدیر با موفقیت حذف شد.'
              : 'اطلاعلات لابی من با موفقیت حذف شد.',
        );

        update();
      },
    );

    isLoading = false;
  }
}
