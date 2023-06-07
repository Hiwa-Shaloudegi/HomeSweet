import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../database/staff_repository.dart';
import '../models/staff.dart';
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
  String role = 'مدیر';

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
      role = 'مدیر';
    } else if (radioGroupValue == 2) {
      role = 'لابی من';
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

    role = 'مدیر';
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
    getAllCosts();
    super.onInit();
  }

  // CRUD
  void getAllCosts() async {
    isLoading = true;
    allStaff.clear();

    allStaff.addAll(await StaffRepository.readAll());

    //Reversing the list to get the recent added items first.
    allStaff = List.from(allStaff.reversed);

    //TODO: delay
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
      AppSnackbar.successSnackbar('اطلاعات ${role} با موفقیت ثبت شد.');
      resetForm();
    } catch (e) {
      throw Exception('CATCH ERROR: $e');
    } finally {
      update();
    }
  }

  updateStaff() async {}
}
