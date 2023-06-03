import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/charge.dart';

class ChargeController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Form
  var floorDropdownButtonValue = 1;
  var unitNumberDropdownButtonValue = 1;
  final titleTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final amountTextController = TextEditingController();

  int floorNumber = 1;
  int unitNumber = 1;
  String title = '';
  String date = '';
  int amount = 0;

  // states
  List allCharges = [];
  Charge? chargeToUpdate;

  // OnSaved
  void titleOnSaved(String? newValue) =>
      title = titleTextController.text.trim();

  void dateOnSaved(String? newValue) => date = dateTextController.text.trim();

  void amountOnSaved(String? newValue) =>
      amount = int.parse(amountTextController.text.trim());

  void unitDropdownButtonOnSaved() =>
      unitNumber = unitNumberDropdownButtonValue;

  void floorDropdownButtonOnSaved() => floorNumber = floorDropdownButtonValue;

  // OnChanged
  void Function(int?)? floorDropdownButtonOnChanged(newValue) {
    floorDropdownButtonValue = newValue;
    floorNumber = floorDropdownButtonValue;
    update();
    return null;
  }

  void Function(int?)? unitDropdownButtonOnChanged(newValue) {
    unitNumberDropdownButtonValue = newValue;
    unitNumber = unitNumberDropdownButtonValue;
    update();
    return null;
  }

  bool validate() => formKey.currentState!.validate();

  void saveCostInputs() {
    formKey.currentState!.save();
    unitDropdownButtonOnSaved();
    floorDropdownButtonOnSaved();
  }

  void resetForm() {
    formKey.currentState!.reset();

    titleTextController.clear();
    dateTextController.clear();
    amountTextController.clear();

    title = '';
    date = '';
    amount = 0;

    floorDropdownButtonValue = 1;
    unitNumberDropdownButtonValue = 1;

    //! TODO: update/edit 'charge state'.
    // chargeToUpdate = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  saveData() async {
    if (validate()) {
      saveCostInputs();

      if (chargeToUpdate != null) {
        createCharge();
      } else {
        updateCharge();
      }
    }
  }

  void createCharge() {}

  void updateCharge() {}
}
