import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/owner_repository.dart';
import 'package:home_sweet/database/tenant_repository.dart';
import 'package:home_sweet/database/unit_repository.dart';
import 'package:home_sweet/models/owner.dart';
import 'package:home_sweet/models/tenant.dart';
import 'package:home_sweet/models/unit.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:sqflite/sqflite.dart';

import '../routes/routes.dart';
import '../widgets/app_dialog.dart';
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
  Unit? unitToUpdate;

  // methods
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    // resetForm();
    super.onClose();
  }

  // Form
  bool validate() => formKey.currentState!.validate();

  void saveUnitInputs() {
    formKey.currentState!.save();
    unitDropdownButtonOnSaved();
    floorDropdownButtonOnSaved();
    // floo
  }

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
    // floorNumber = 1;
    // unitNumber = 1;
    radioGroupValue = 1;
    isTenantFormVisible = false;
    //!
    unitToUpdate = null;
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

  void floorDropdownButtonOnSaved() => floorNumber = floorDropdownButtonValue;

  void Function(int?)? unitDropdownButtonOnChanged(newValue) {
    unitNumberDropdownButtonValue = newValue;
    unitNumber = unitNumberDropdownButtonValue;
    update();
    return null;
  }

  void unitDropdownButtonOnSaved() =>
      unitNumber = unitNumberDropdownButtonValue;

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

  //TODO:!
  // void radioOnSaved() {
  //   if (unitStatus == UnitStatus.tenant) {

  //   }
  // }
  // Database
  saveData() async {
    if (validate()) {
      saveUnitInputs();

      if (unitToUpdate == null) {
        Unit? unitToCheck = await UnitRepository.getUnitByFloorAndNumber(
          Unit(floor: floorNumber, number: unitNumber),
        );

        if (unitToCheck != null) {
          // this unit exist in database already.
          AppSnackbar.errorSnackbar(
            'اطلاعات واحد $unitNumber طبقه $floorNumber قبلا ثبت شده است.'
                .toFarsiNumber,
          );
          return;
        }

        var newOwner = Owner(
          firstName: ownerName,
          lastName: ownerLastName,
          ownerPhoneNumber: ownerPhoneNumber,
        );
        newOwner = await OwnerRepository.create(newOwner);

        late Tenant? newTenant;
        if (unitStatus == UnitStatus.tenant) {
          newTenant = Tenant(
            firstName: tenantName,
            lastName: tenantLastName,
            tenantPhoneNumber: tenantPhoneNumber,
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
            tenant: unitStatus == UnitStatus.tenant ? newTenant! : null,
          );
          await UnitRepository.create(newUnit);
          allUnits.insert(0, newUnit);

          Get.back();
          AppSnackbar.successSnackbar('اطلاعات واحد با موفقیت ثبت شد.');
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
      } else {
        updateUnit();
      }
      update();
    }
  }

  void loadSelectedUnitData() async {
    if (unitToUpdate != null) {
      floorDropdownButtonValue = unitToUpdate!.floor!;
      unitNumberDropdownButtonValue = unitToUpdate!.number!;
      unitPhoneNumberTextController.text = unitToUpdate!.phoneNumber!;

      if (unitToUpdate!.unitStatus! == UnitStatus.owner.toString()) {
        radioGroupValue = 1;
        isTenantFormVisible = false;
        unitStatus = UnitStatus.owner;
      } else if (unitToUpdate!.unitStatus! == UnitStatus.empty.toString()) {
        radioGroupValue = 2;
        isTenantFormVisible = false;
        unitStatus = UnitStatus.empty;
      } else {
        radioGroupValue = 3;
        isTenantFormVisible = true;
        unitStatus = UnitStatus.tenant;
      }

      ownerNameTextController.text = unitToUpdate!.owner!.firstName!;
      ownerLastNameTextController.text = unitToUpdate!.owner!.lastName!;
      ownerPhoneNumberTextController.text =
          unitToUpdate!.owner!.ownerPhoneNumber!;

      if (unitToUpdate!.tenant != null) {
        tenantNameTextController.text = unitToUpdate!.tenant!.firstName!;
        tenantLastNameTextController.text = unitToUpdate!.tenant!.lastName!;
        tenantPhoneNumberTextController.text =
            unitToUpdate!.tenant!.tenantPhoneNumber!;
      }
    }
    update();
  }

  updateUnit() async {
    if (validate()) {
      saveUnitInputs();

      try {
        var updatedOwner = Owner(
          id: unitToUpdate!.ownerId,
          firstName: ownerName,
          lastName: ownerLastName,
          ownerPhoneNumber: ownerPhoneNumber,
        );
        await OwnerRepository.update(updatedOwner);

        late Tenant? updatedTenant;
        late Tenant? newTenant;

        //!!!!!!!!!!!! Error: converting tennt state to owner state.
        // if (unitStatus != UnitStatus.tenant) {
        //   tenantNameTextController.clear();
        //   tenantLastNameTextController.clear();
        //   tenantPhoneNumberTextController.clear();
        // }
        if (unitStatus == UnitStatus.tenant) {
          if (unitToUpdate!.tenantId == null) {
            newTenant = Tenant(
              firstName: tenantName,
              lastName: tenantLastName,
              tenantPhoneNumber: tenantPhoneNumber,
            );
            newTenant = await TenantRepository.create(newTenant);

            var updatedUnit = Unit(
              id: unitToUpdate!.id,
              floor: floorNumber,
              number: unitNumber,
              phoneNumber: unitPhoneNumber,
              unitStatus: unitStatus.toString(),
              ownerId: updatedOwner.id,
              tenantId: unitStatus == UnitStatus.tenant ? newTenant.id : null,
              owner: updatedOwner,
              tenant: unitStatus == UnitStatus.tenant ? newTenant : null,
            );
            await UnitRepository.update(updatedUnit);

            int index =
                allUnits.indexWhere((unit) => unit.id == unitToUpdate!.id);
            if (index != -1) {
              allUnits[index] = updatedUnit;
            }
          } else {
            updatedTenant = Tenant(
              id: unitToUpdate!.tenantId,
              firstName: tenantName,
              lastName: tenantLastName,
              tenantPhoneNumber: tenantPhoneNumber,
            );
            await TenantRepository.update(updatedTenant);

            var updatedUnit = Unit(
              id: unitToUpdate!.id,
              floor: floorNumber,
              number: unitNumber,
              phoneNumber: unitPhoneNumber,
              unitStatus: unitStatus.toString(),
              ownerId: updatedOwner.id,
              tenantId:
                  unitStatus == UnitStatus.tenant ? updatedTenant.id : null,
              owner: updatedOwner,
              tenant: unitStatus == UnitStatus.tenant ? updatedTenant : null,
            );
            await UnitRepository.update(updatedUnit);

            int index =
                allUnits.indexWhere((unit) => unit.id == unitToUpdate!.id);
            if (index != -1) {
              allUnits[index] = updatedUnit;
            }
          }
        } else {
          // changing the unitStatus from tenant to other.
          if (unitToUpdate!.tenantId != null) {
            // tenant info will be deleted.
            await TenantRepository.delete(unitToUpdate!.tenantId!);
          }
          var updatedUnit = Unit(
            id: unitToUpdate!.id,
            floor: floorNumber,
            number: unitNumber,
            phoneNumber: unitPhoneNumber,
            unitStatus: unitStatus.toString(),
            ownerId: updatedOwner.id,
            tenantId: null,
            owner: updatedOwner,
            tenant: null,
          );
          await UnitRepository.update(updatedUnit);

          int index =
              allUnits.indexWhere((unit) => unit.id == unitToUpdate!.id);
          if (index != -1) {
            allUnits[index] = updatedUnit;
          }
        }

        Get.back();
        AppSnackbar.successSnackbar('اطلاعات واحد با موفقیت بروزرسانی شد.');
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
    }

    isLoading = false;
    unitToUpdate = null;

    update();
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

  deleteUnit(int id) async {
    isLoading = true;
    await showAppDialog(
      title: 'هشدار',
      message: 'آیا مطمئن هستید که می خواهید این واحد را حذف کنید؟',
      textConfirm: 'بلی',
      textCancel: 'خیر',
      onConfirm: () async {
        var unitToBeDeleted = await UnitRepository.read(id);

        await UnitRepository.delete(id);

        var ownerToBeDeleted = unitToBeDeleted!.owner;
        await OwnerRepository.delete(ownerToBeDeleted!.id!);

        if (unitToBeDeleted.tenant != null) {
          var tenantToBeDeleted = unitToBeDeleted.tenant;
          await TenantRepository.delete(tenantToBeDeleted!.id!);
        }

        // Removes any snackbar or dialog on the stack until it gets to the actual screen.
        Navigator.of(Get.overlayContext!)
            .popUntil(ModalRoute.withName(AppRoutes.unitPage));

        // Also removes the unit from list of costs state.
        allUnits.removeWhere((unit) => unit.id == id);
        AppSnackbar.successSnackbar('اطلاعلات واحد با موفقیت حذف شد.');
        isLoading = false;

        update();
      },
    );
  }
}
