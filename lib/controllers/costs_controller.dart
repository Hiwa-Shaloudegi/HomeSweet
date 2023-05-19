import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/cost_repository.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../constants/colors.dart';
import '../models/cost.dart';
import '../widgets/snackbar.dart';

class CostsController extends GetxController {
  var costItems = [
    Row(
      children: [
        Icon(
          Icons.attach_money_rounded,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 12),
        Text('هزینه کل :  '),
        Text('800000'.toTooman()),
        Text('  تومان'),
      ],
    ),
    Row(
      children: [
        Icon(
          Icons.calendar_month_rounded,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 12),
        Text('تاریخ :'),
        Text(' 12 اریبهشت 1402'.toFarsiNumber),
      ],
    ),
    Row(
      children: [
        Icon(
          Icons.edit_document,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 12),
        Text('توضیحات :'),
        Text('بابت نظافت کامل، راه پله ها و ... '),
      ],
    ),
  ];

  final formKey = GlobalKey<FormState>();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final amountTextController = TextEditingController();
  //TODO: take an image of receipt

  String title = '';
  String description = '';
  String date = '';
  double amount = 0;

  int numberOfUnits = 0;
  Cost? cost;
  List allCosts = [1];

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
    amount = double.parse(amountTextController.text.trim());
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
    formKey.currentState!.reset();
    //TODO: Is this a write thing to do?
    title = '';
    description = '';
    date = '';
    amount = 0;
    numberOfUnits = 0;
  }

  bool isLoading = false;
  void getAllCosts() async {
    isLoading = true;
    allCosts.addAll(await CostRepository.readAll());

    isLoading = false;
    update();
  }

  // isLoading = false;
  void createCost() async {
    if (validate()) {
      // isLoading = false;

      saveCostInputs();

      var newCost = Cost(
        title: title,
        description: description,
        date: DateTime.parse(date),
        amount: amount,
        receiptImage: '',
      );

      try {
        cost = await CostRepository.create(newCost);

        Get.back();
        resetForm();
        AppSnackbar.successSnackbar('اطلاعات هزینه با موفقیت ثبت شد.');
      } catch (e) {
        print('CATCH ERROR: $e');
      }
    }

    update();
  }
}
