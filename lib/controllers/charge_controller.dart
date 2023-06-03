import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/charge_repository.dart';
import 'package:home_sweet/database/unit_repository.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/widgets/snackbar.dart';

import '../models/charge.dart';
import '../models/unit.dart';

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

  void saveChargeInputs() {
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
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  bool isLoading = false;
  loadData() async {
    isLoading = true;
    allCharges.clear();

    allCharges.addAll(await ChargeRepository.readAll());
    allCharges = List.from(allCharges.reversed);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
    update();
  }

  saveData() async {
    if (validate()) {
      saveChargeInputs();

      if (chargeToUpdate == null) {
        createCharge();
      } else {
        updateCharge();
      }
    }

    update();
  }

  void createCharge() async {
    Unit? relatedUnit = await UnitRepository.getUnitByFloorAndNumber(
      Unit(floor: floorNumber, number: unitNumber),
    );

    if (relatedUnit == null) {
      // No such unit in database.
      AppSnackbar.errorSnackbar(
        'اطلاعات واحد $unitNumber طبقه $floorNumber ثبت نشده است.',
        buttonText: 'افزودن واحد',
        onTap: () => Get.toNamed(AppRoutes.unitPage),
      );
      return;
    }

    Charge newCharge = Charge(
      title: title,
      date: date,
      amount: amount,
      unitId: relatedUnit.id,
    );

    try {
      newCharge = await ChargeRepository.create(newCharge);
      allCharges.insert(0, newCharge);

      Get.back();
      AppSnackbar.successSnackbar(
          'اطلاعات شارژ با موفقیت ثبت شد.'); //TODO: charge or somthing else.
      resetForm();
    } catch (e) {
      throw Exception('CATCH ERROR: $e');
    }
  }

  void updateCharge() async {}
}
