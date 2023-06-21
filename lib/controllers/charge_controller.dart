import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweet_home/database/charge_repository.dart';
import 'package:sweet_home/database/unit_repository.dart';
import 'package:sweet_home/routes/routes.dart';
import 'package:sweet_home/utils/extensions.dart';
import 'package:sweet_home/widgets/snackbar.dart';

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
  // TODO1:
  // TextEditingController(
  //   text: Get.find<ApartmentFormController>().apartment!.unitCharge.toString(),
  // );

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
    // TODO1: automatically change the amout textField when the title dropdown changes without activating the form validation which is set to onUserInrteraction.
    // if (titleDropDownFieldValue == 'شارژ ماهیانه') {
    //   amountTextController.text =
    //       Get.find<ApartmentFormController>().apartment!.unitCharge.toString();

    //   log('AMOUNT TEXT: ${amountTextController.text}');
    // } else {
    //   amountTextController.clear();
    // }
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
    if (formKey.currentState != null) {
      formKey.currentState!.reset();
    }
    titleDropDownFieldValue = 'شارژ ماهیانه';
    dateTextController.clear();
    amountTextController.clear();

    // title = '';
    date = '';
    amount = 0;

    floorDropdownButtonValue = 1;
    unitNumberDropdownButtonValue = 1;

    chargeToUpdate = null;
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
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

  createCharge() async {
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

      Navigator.of(Get.overlayContext!)
          .popUntil(ModalRoute.withName(AppRoutes.chargePage));

      AppSnackbar.successSnackbar('اطلاعات $title با موفقیت ثبت شد.');
    } catch (e) {
      throw Exception('CATCH ERROR: $e');
    } finally {
      update();
    }
  }

  loadSelectedChargeData() async {
    if (chargeToUpdate != null) {
      Unit? relatedUnit = await UnitRepository.read(chargeToUpdate!.unitId!);

      floorDropdownButtonValue = relatedUnit!.floor!;
      unitNumberDropdownButtonValue = relatedUnit.number!;

      titleDropDownFieldValue = chargeToUpdate!.title!;
      dateTextController.text = chargeToUpdate!.date!;
      amountTextController.text = chargeToUpdate!.amount.toString();
    }
    update();
  }

  updateCharge() async {
    Unit? relatedUpdatedUnit = await UnitRepository.getUnitByFloorAndNumber(
      Unit(floor: floorNumber, number: unitNumber),
    );

    if (relatedUpdatedUnit == null) {
      // No such unit in database.
      AppSnackbar.errorSnackbar(
        'اطلاعات واحد $unitNumber طبقه $floorNumber ثبت نشده است.'
            .toFarsiNumber,
        buttonText: 'افزودن واحد',
        onTap: () => Get.toNamed(AppRoutes.unitPage),
      );
      return;
    }

    var updatedCharge = Charge(
      id: chargeToUpdate!.id,
      title: title,
      date: date,
      amount: amount,
      unitId: relatedUpdatedUnit.id,
    );

    try {
      await ChargeRepository.update(updatedCharge);

      int index =
          allCharges.indexWhere((charge) => charge.id == chargeToUpdate!.id);
      if (index != -1) {
        allCharges[index] = updatedCharge;
      }

      Get.back();
      AppSnackbar.successSnackbar('اطلاعات با موفقیت بروز رسانی شد.');
    } catch (e) {
      throw Exception('CATCH ERROR: $e');
    }

    chargeToUpdate = null;

    update();
  }

  deleteCharge(int id) async {
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

        // Also removes the charge from list of costs state.
        allCharges.removeWhere((charge) => charge.id == id);
        AppSnackbar.successSnackbar('اطلاعات قبض با موفقیت حذف شد.');

        update();
      },
    );

    isLoading = false;
    update();
  }

  Future<Unit?> getRelatedUnit(Charge charge) async {
    return await UnitRepository.read(charge.unitId!);
  }
}
