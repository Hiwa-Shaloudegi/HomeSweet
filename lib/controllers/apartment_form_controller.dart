import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApartmentFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final apartmentNameTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final chargeAmountTextController = TextEditingController();
  final budgetTextController = TextEditingController();

  String apartmentName = '';
  String address = '';
  String chargeAmount = '';
  String budget = '';
  int storyNumber = 0;
  int unitNumber = 0;

  void apartmentNameOnSaved(String? newValue) {
    apartmentName = apartmentNameTextController.text.trim();
  }

  void addressOnSaved(String? newValue) {
    address = addressTextController.text.trim();
  }

  void chargeAmountOnSaved(String? newValue) {
    chargeAmount = chargeAmountTextController.text.trim();
  }

  void budgetOnSaved(String? newValue) {
    budget = budgetTextController.text.trim();
  }

  void addStoryNumber() {
    storyNumber++;
    update();
  }

  void removeStoryNumber() {
    if (storyNumber != 0) {
      storyNumber--;
      update();
    }
  }

  void addUnitNumber() {
    unitNumber++;
    update();
  }

  void removeUnitNumber() {
    if (unitNumber != 0) {
      unitNumber--;
      update();
    }
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  void saveApartmentInputs() {
    formKey.currentState!.save();
  }

  void resetForm() {
    formKey.currentState!.reset();
  }

  void saveApartmentInfo() {
    if (validate()) {
      saveApartmentInputs();

      // Save datas to Database
      // var user = User(
      //   username: signupFormController.username,
      //   password: signupFormController.password,
      // );
      // signupFormController.resetForm();

      // try {
      //   await UserRepository.create(user);

      //   // Transition to the home page
      //   Get.offAndToNamed(AppRoutes.loginScreen);
      //   AppSnackbar.successSnackbar('حساب کاربری با موفقیت ساخته شد.');
      // } catch (e) {
      //   print('CATCH ERROR: $e');
      // }
    }
  }
}
