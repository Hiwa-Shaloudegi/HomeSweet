import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/cost_repository.dart';
import 'package:home_sweet/routes/routes.dart';
import 'package:home_sweet/widgets/app_dialog.dart';

import '../models/cost.dart';
import '../widgets/snackbar.dart';

class CostsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final amountTextController = TextEditingController();
  //TODO: take an image of receipt

  String title = '';
  String description = '';
  String date = '';
  int amount = 0;

  bool isBottomSheetOpen = false;

  int numberOfUnits = 0;
  Cost? costToUpdate;
  List<Cost> allCosts = [];

  @override
  void onInit() {
    getAllCosts();
    super.onInit();
  }

  @override
  void onClose() {
    titleTextController.clear();
    descriptionTextController.clear();
    dateTextController.clear();
    amountTextController.clear();
    super.onClose();
  }

  void titleOnSaved(String? newValue) {
    title = titleTextController.text.trim();
  }

  void descriptionOnSaved(String? newValue) {
    description = descriptionTextController.text.trim();
  }

  void dateOnSaved(String? newValue) {
    date = dateTextController.text.trim();
  }

  void amountOnSaved(String? newValue) {
    amount = int.parse(amountTextController.text.trim());
  }

  void addnumberOfUnits() {
    //TODO: get the units number from apartment table?
    //!
    if (numberOfUnits < 5) {
      numberOfUnits++;
      update();
    }
  }

  void removenumberOfUnits() {
    if (numberOfUnits != 0) {
      numberOfUnits--;
      update();
    }
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  void saveCostInputs() {
    formKey.currentState!.save();
  }

  void resetForm() {
    if (formKey.currentState != null) {
      formKey.currentState!.reset();
    }

    titleTextController.clear();
    descriptionTextController.clear();
    dateTextController.clear();
    amountTextController.clear();
    title = '';
    description = '';
    date = '';
    amount = 0;
    numberOfUnits = 0;

    costToUpdate = null;
  }

  // CRUD
  bool isLoading = false;
  void getAllCosts() async {
    isLoading = true;
    allCosts.clear();

    allCosts.addAll(await CostRepository.readAll());

    //Reversing the list to get the recent added items first.
    allCosts = List.from(allCosts.reversed);

    //TODO: delay
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
    update();
  }

  // //!
  // void getId(Cost cost) async {
  //   var id = CostRepository.getId(cost);
  // }

  void createCost() async {
    if (validate()) {
      isLoading = true;

      saveCostInputs();

      if (costToUpdate == null) {
        var newCost = Cost(
          title: title,
          description: description,
          date: date,
          amount: amount,
          receiptImage: '',
        );

        try {
          var cost = await CostRepository.create(newCost);
          allCosts.insert(0, cost);

          Get.back();
          AppSnackbar.successSnackbar('اطلاعات هزینه با موفقیت ثبت شد.');
        } catch (e) {
          throw Exception('CATCH ERROR: $e');
        }
      } else {
        updateCost();
      }
    }

    isLoading = false;
    update();
  }

  void loadSelectedCostData() async {
    if (costToUpdate != null) {
      titleTextController.text = costToUpdate!.title!;
      descriptionTextController.text = costToUpdate!.description!;
      dateTextController.text = costToUpdate!.date!;
      amountTextController.text = costToUpdate!.amount.toString();
    }
    update();
  }

  void updateCost() async {
    if (validate()) {
      isLoading = true;

      saveCostInputs();

      var updatedCost = Cost(
        id: costToUpdate!.id,
        title: title,
        description: description,
        date: date,
        amount: amount,
        receiptImage: '', //receiptImage,
      );

      try {
        await CostRepository.update(updatedCost);

        int index = allCosts.indexWhere((cost) => cost.id == costToUpdate!.id);
        if (index != -1) {
          allCosts[index] = updatedCost;
        }

        Get.back();
        AppSnackbar.successSnackbar('اطلاعات با موفقیت بروز رسانی شد.');
      } catch (e) {
        throw Exception('CATCH ERROR: $e');
      }
    }

    isLoading = false;
    costToUpdate = null;

    update();
  }

  void deleteCost(int id) async {
    isLoading = true;
    await showAppDialog(
      title: 'هشدار',
      message: 'آیا مطمئن هستید که می خواهید این مورد را حذف کنید؟',
      textConfirm: 'بلی',
      textCancel: 'خیر',
      onConfirm: () async {
        await CostRepository.delete(id);

        // Removes any snackbar or dialog on the stack until it gets to the actual screen.
        Navigator.of(Get.overlayContext!)
            .popUntil(ModalRoute.withName(AppRoutes.costsPage));

        // Also removes the cost from list of costs state.
        allCosts.removeWhere((cost) => cost.id == id);
        AppSnackbar.successSnackbar('اطلاعلات هزینه با موفقیت حذف شد.');

        update();
      },
    );

    isLoading = false;
  }
}
