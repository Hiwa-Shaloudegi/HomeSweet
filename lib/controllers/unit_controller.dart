import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/models/unit.dart';

class UnitFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Apartment
  var floorDropdownButtonValue = 1;
  var unitNumberDropdownButtonValue = 1;
  final unitPhoneNumberTextController = TextEditingController();
  var radioGroupValue = 1;
  var isTenantFormVisible = false;

  String unitPhoneNumber = '';
  UnitStatus unitStatus = UnitStatus.owner;
  int floorNumber = 1;
  int unitNumber = 1;
  // Owner
  final ownerNameTextController = TextEditingController();
  final ownerLastNameTextController = TextEditingController();
  final ownerPhoneNumberTextController = TextEditingController();

  String ownerName = '';
  String ownerLastName = '';
  String ownerPhoneNumber = '';

  // Tenat
  final tenantNameTextController = TextEditingController();
  final tenantLastNameTextController = TextEditingController();
  final tenantPhoneNumberTextController = TextEditingController();

  String tenantName = '';
  String tenantLastName = '';
  String tenantPhoneNumber = '';

  // methods
  @override
  void onInit() {
    // TODO: implement onInit
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
}
