import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/staff.dart';

class StaffController extends GetxController {
  // Form
  final formKey = GlobalKey<FormState>();

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final salaryTextController = TextEditingController();
  var radioGroupValue = 1;

  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String date = '';
  int salary = 0;
  String role = 'مدیر';

  // States
  bool isLoading = false;
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
    radioGroupValue = 1;

    role = 'مدیر';
    firstName = '';
    lastName = '';
    phoneNumber = '';
    date = '';
    salary = 0;

    staffToUpdate = null;
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

  createStaff() async {}
  updateStaff() async {}
}
