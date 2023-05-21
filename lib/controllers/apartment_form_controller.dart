import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/apartment_repository.dart';
import 'package:home_sweet/models/apartment.dart';

import '../routes/routes.dart';
import '../widgets/snackbar.dart';

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

  Apartment? apartment;

  @override
  void onInit() {
    loadApartmentData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    apartmentNameTextController.clear();
    addressTextController.clear();
    chargeAmountTextController.clear();
    budgetTextController.clear();
  }

  void loadApartmentData() async {
    apartment = await ApartmentRepository.read(1);
    if (apartment != null) {
      apartmentNameTextController.text = apartment!.apartmentName!;
      addressTextController.text = apartment!.address!;
      chargeAmountTextController.text = apartment!.unitCharge.toString();
      budgetTextController.text = apartment!.budget.toString();
      storyNumber = apartment!.storyNumber!;
      unitNumber = apartment!.unitNumber!;
    }

    update();
  }

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

  void saveApartmentInfo() async {
    if (validate()) {
      saveApartmentInputs();

      // Create
      if (apartment == null) {
        // Save datas to Database
        var newApartment = Apartment(
          apartmentName: apartmentName,
          address: address,
          storyNumber: storyNumber,
          unitNumber: unitNumber,
          unitCharge: double.parse(chargeAmount),
          budget: double.parse(budget),
        );

        try {
          apartment = await ApartmentRepository.create(newApartment);

          // Transition to the home page
          Get.offAndToNamed(AppRoutes.mainScreen);
          AppSnackbar.successSnackbar('اطلاعات آپارتمان با موفقیت ثبت شد.');
        } catch (e) {
          throw Exception('CATCH ERROR: $e');
        }

        //Update
      } else {
        // Save datas to Database
        var updatedApartment = Apartment(
          id: 1, //apartment!.id,
          apartmentName: apartmentName,
          address: address,
          storyNumber: storyNumber,
          unitNumber: unitNumber,
          unitCharge: double.parse(chargeAmount),
          budget: double.parse(budget),
        );

        try {
          await ApartmentRepository.update(updatedApartment);
          apartment = updatedApartment;

          AppSnackbar.successSnackbar('اطلاعات با موفقیت بروز رسانی شد.');
        } catch (e) {
          throw Exception('CATCH ERROR: $e');
        }
      }
    }
    update();
  }
}
