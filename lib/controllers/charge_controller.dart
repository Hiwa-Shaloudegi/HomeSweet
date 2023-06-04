import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/charge_repository.dart';
import 'package:home_sweet/database/unit_repository.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:home_sweet/widgets/snackbar.dart';

import '../models/charge.dart';
import '../models/unit.dart';
import '../widgets/app_dialog.dart';

class ChargeController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Form
  var floorDropdownButtonValue = 1;
  var unitNumberDropdownButtonValue = 1;
  String? titleDropDownFieldValue = 'شارژ ماهیانه';
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
  void titleDropDownOnSaved(String? newValue) => title = newValue!;

  void dateOnSaved(String? newValue) => date = dateTextController.text.trim();

  void amountOnSaved(String? newValue) =>
      amount = int.parse(amountTextController.text.trim());

  void unitDropdownButtonOnSaved() =>
      unitNumber = unitNumberDropdownButtonValue;

  void floorDropdownButtonOnSaved() => floorNumber = floorDropdownButtonValue;

  void titleDropDownFieldOnSaved() => title = titleDropDownFieldValue!;

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

  void Function(int?)? titleDropDownFieldOnChanged(newValue) {
    titleDropDownFieldValue = newValue;
    title = titleDropDownFieldValue!;
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

    titleDropDownFieldValue = 'شارژ ماهیانه';
    dateTextController.clear();
    amountTextController.clear();

    // title = '';
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
        'اطلاعات واحد $unitNumber طبقه $floorNumber ثبت نشده است.'
            .toFarsiNumber,
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
    } finally {
      update();
    }
  }

  void updateCharge() async {}

  void deleteCharge(int id) async {
    isLoading = true;
    await showAppDialog(
      title: 'هشدار',
      message: 'آیا مطمئن هستید که می خواهید این مورد را حذف کنید؟',
      textConfirm: 'بلی',
      textCancel: 'خیر',
      onConfirm: () async {
        await ChargeRepository.delete(id);

        // Removes any snackbar or dialog on the stack until it gets to the actual screen.
        Navigator.of(Get.overlayContext!)
            .popUntil(ModalRoute.withName(AppRoutes.chargePage));

        // Also removes the cost from list of costs state.
        allCharges.removeWhere((charge) => charge.id == id);
        AppSnackbar.successSnackbar('اطلاعلات قبض با موفقیت حذف شد.');

        update();
      },
    );

    isLoading = false;
    update();
  }
}
