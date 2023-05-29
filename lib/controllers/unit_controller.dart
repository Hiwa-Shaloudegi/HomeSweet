import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/owner_repository.dart';
import 'package:home_sweet/database/tenant_repository.dart';
import 'package:home_sweet/database/unit_repository.dart';
import 'package:home_sweet/models/owner.dart';
import 'package:home_sweet/models/tenant.dart';
import 'package:home_sweet/models/unit.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/snackbar.dart';

class UnitFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Apartment Form
  var floorDropdownButtonValue = 1;
  var unitNumberDropdownButtonValue = 1;
  final unitPhoneNumberTextController = TextEditingController();
  var radioGroupValue = 1;
  var isTenantFormVisible = false;

  String unitPhoneNumber = '';
  UnitStatus unitStatus = UnitStatus.owner;
  int floorNumber = 1;
  int unitNumber = 1;

  // Owner Form
  final ownerNameTextController = TextEditingController();
  final ownerLastNameTextController = TextEditingController();
  final ownerPhoneNumberTextController = TextEditingController();

  String ownerName = '';
  String ownerLastName = '';
  String ownerPhoneNumber = '';

  // Tenat Form
  final tenantNameTextController = TextEditingController();
  final tenantLastNameTextController = TextEditingController();
  final tenantPhoneNumberTextController = TextEditingController();

  String tenantName = '';
  String tenantLastName = '';
  String tenantPhoneNumber = '';

  // states
  List<Unit> allUnits = [];

  // methods
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    resetForm();
    super.onClose();
  }

  // Form
  bool validate() => formKey.currentState!.validate();

  void saveUnitInputs() => formKey.currentState!.save();

  void resetForm() {
    formKey.currentState!.reset();

    unitPhoneNumberTextController.clear();
    ownerNameTextController.clear();
    ownerLastNameTextController.clear();
    ownerPhoneNumberTextController.clear();
    tenantNameTextController.clear();
    tenantLastNameTextController.clear();
    tenantPhoneNumberTextController.clear();

    unitPhoneNumber = '';
    ownerName = '';
    ownerLastName = '';
    ownerPhoneNumber = '';
    tenantName = '';
    tenantLastName = '';
    tenantPhoneNumber = '';

    floorDropdownButtonValue = 1;
    unitNumberDropdownButtonValue = 1;
    floorNumber = 1;
    unitNumber = 1;
    radioGroupValue = 1;
    isTenantFormVisible = false;
  }

  // OnSaved
  void unitPhoneNumberOnSaved(String? newValue) {
    unitPhoneNumber = unitPhoneNumberTextController.text.trim();
  }

  void ownerNameOnSaved(String? newValue) {
    ownerName = ownerNameTextController.text.trim();
  }

  void ownerLastNameOnSaved(String? newValue) {
    ownerLastName = ownerLastNameTextController.text.trim();
  }

  void ownerPhoneNumberOnSaved(String? newValue) {
    ownerPhoneNumber = ownerPhoneNumberTextController.text.trim();
  }

  void tenantNameOnSaved(String? newValue) {
    tenantName = tenantNameTextController.text.trim();
  }

  void tenantLastNameOnSaved(String? newValue) {
    tenantLastName = tenantLastNameTextController.text.trim();
  }

  void tenantPhoneNumberOnSaved(String? newValue) {
    tenantPhoneNumber = tenantPhoneNumberTextController.text.trim();
  }

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

  void Function(int?)? radioOnChanged(value) {
    radioGroupValue = value;
    if (radioGroupValue == 1) {
      isTenantFormVisible = false;
      unitStatus = UnitStatus.owner;
    } else if (radioGroupValue == 2) {
      isTenantFormVisible = false;
      unitStatus = UnitStatus.empty;
    } else if (radioGroupValue == 3) {
      isTenantFormVisible = true;
      unitStatus = UnitStatus.tenant;
    }
    update();
    return null;
  }

  // Database
  saveData() async {
    if (validate()) {
      saveUnitInputs();

      var newOwner = Owner(
        firstName: ownerName,
        lastName: ownerLastName,
        phoneNumber: ownerPhoneNumber,
      );
      newOwner = await OwnerRepository.create(newOwner);

      late Tenant? newTenant;
      if (unitStatus == UnitStatus.tenant) {
        newTenant = Tenant(
          firstName: tenantName,
          lastName: tenantLastName,
          phoneNumber: tenantPhoneNumber,
        );
        newTenant = await TenantRepository.create(newTenant);
      }

      try {
        var newUnit = Unit(
          floor: floorNumber,
          number: unitNumber,
          phoneNumber: unitPhoneNumber,
          unitStatus: unitStatus.toString(),
          ownerId: newOwner.id,
          tenantId: unitStatus == UnitStatus.tenant ? newTenant!.id : null,
          owner: newOwner,
          tenant: unitStatus == UnitStatus.tenant ? newTenant : null,
        );
        await UnitRepository.create(newUnit);
        allUnits.insert(0, newUnit);

        Get.back();
        AppSnackbar.successSnackbar('اطلاعات واحد با موفقیت ثبت شد.');
        resetForm();
      } catch (e) {
        if (e is DatabaseException && e.isUniqueConstraintError()) {
          AppSnackbar.errorSnackbar(
              'اطلاعات این مستاجر قبلا برای واحد دیگری ثبت شده است.');
          throw Exception(
              'The tenant ID is already in use. Please choose a different tenant ID.');
        } else {
          rethrow;
        }
      }

      update();
    }
  }

  bool isLoading = false;
  loadData() async {
    isLoading = true;
    allUnits.clear();

    allUnits.addAll(await UnitRepository.readAll());
    allUnits = List.from(allUnits.reversed);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
    update();
  }
}
