import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/controllers/apartment_form_controller.dart';
import 'package:home_sweet/controllers/auth_controller.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';
import 'package:home_sweet/utils/validators.dart';

import 'widgets/counter_icon_button.dart';
import 'widgets/header_image.dart';

class ApartmentFormPage extends StatelessWidget {
  ApartmentFormPage({super.key});

  // Controllers
  final apartmentFormController =
      Get.put(ApartmentFormController(), permanent: true);

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: apartmentFormBody(),
    );
  }
}

Widget apartmentFormBody() {
  final apartmentFormController = Get.put(ApartmentFormController());
  final authController = Get.find<AuthController>();

  return GetBuilder<ApartmentFormController>(builder: (_) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderImage(),
          const SizedBox(height: 16),
          const Text(
            'ثبت اطلاعات آپارتمان',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 18),
          Form(
            key: apartmentFormController.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                    controller:
                        apartmentFormController.apartmentNameTextController,
                    hintText: 'نام آپارتمان',
                    enabled: authController.loggedInUser!.role == 'manager',
                    validator: (value) => Validators.textInputValidator(value),
                    onSaved: (newValue) =>
                        apartmentFormController.apartmentNameOnSaved(newValue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('تعداد طبقات:'),
                        CountIconButton.add(
                          onPressed: authController.loggedInUser!.role ==
                                  'manager'
                              ? () => apartmentFormController.addStoryNumber()
                              : () {},
                        ),
                        // TODO: Fix the input number by keyboard.
                        Text('${apartmentFormController.storyNumber}'),
                        CountIconButton.minus(
                          onPressed: authController.loggedInUser!.role ==
                                  'manager'
                              ? () =>
                                  apartmentFormController.removeStoryNumber()
                              : () {},
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          color: const Color(0xffCACACF),
                        ),
                        const Text('تعداد واحدها:'),
                        CountIconButton.add(
                          onPressed: authController.loggedInUser!.role ==
                                  'manager'
                              ? () => apartmentFormController.addUnitNumber()
                              : () {},
                        ),
                        Text('${apartmentFormController.unitNumber}'),
                        CountIconButton.minus(
                          onPressed: authController.loggedInUser!.role ==
                                  'manager'
                              ? () => apartmentFormController.removeUnitNumber()
                              : () {},
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    controller: apartmentFormController.addressTextController,
                    hintText: 'آدرس',
                    enabled: authController.loggedInUser!.role == 'manager',
                    validator: (value) => Validators.textInputValidator(value),
                    onSaved: (newValue) =>
                        apartmentFormController.addressOnSaved(newValue),
                    suffixIcon: const Icon(
                      Icons.location_on_rounded,
                      size: 24,
                      color: AppColors.unselectedItemColor,
                    ),
                  ),
                  CustomTextField(
                    controller:
                        apartmentFormController.chargeAmountTextController,
                    hintText: 'شارژ ماهیانه هر واحد',
                    enabled: authController.loggedInUser!.role == 'manager',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.amountInputValidator(value),
                    onSaved: (newValue) =>
                        apartmentFormController.chargeAmountOnSaved(newValue),
                  ),
                  CustomTextField(
                    controller: apartmentFormController.budgetTextController,
                    hintText: 'موجودی صندوق',
                    enabled: authController.loggedInUser!.role == 'manager',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.amountInputValidator(value),
                    // onChanged: (value) {
                    // TODO: FIX the issue: farsi number in textField
                    //   if (value != null) {
                    //     // apartmentFormController.budgetTextController.text =
                    //     //     value.toTooman();

                    //     // apartmentFormController.budgetTextController.text =
                    //     //     value.toTooman();

                    //     // ScaffoldMessenger.of(context).showSnackBar(
                    //     //   SnackBar(
                    //     //     content: Text(
                    //     //         '${apartmentFormController.budgetTextController.text}'),
                    //     //   ),
                    //     // );
                    //   }
                    // },
                    onSaved: (newValue) =>
                        apartmentFormController.budgetOnSaved(newValue),
                  ),
                  Visibility(
                    visible: Get.find<AuthController>().loggedInUser!.role ==
                        'manager',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: SaveButton(
                        text: 'ثبت اطلاعات',
                        onPressed: () {
                          apartmentFormController.saveApartmentInfo();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  });
}
