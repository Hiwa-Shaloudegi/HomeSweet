import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/controllers/apartment_form_controller.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';
import 'package:home_sweet/utils/validators.dart';

import 'widgets/counter_icon_button.dart';
import 'widgets/header_image.dart';

class ApartmentFormPage extends StatelessWidget {
  ApartmentFormPage({super.key});

  // Controllers
  final apartmentFormController = Get.put(ApartmentFormController());

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ApartmentFormController>(
          builder: (apartmentFormController) {
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
                        validator: (value) =>
                            Validators.textInputValidator(value),
                        onSaved: (newValue) => apartmentFormController
                            .apartmentNameOnSaved(newValue),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Container(
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('تعداد طبقات:'),
                              CountIconButton.add(
                                onPressed: () =>
                                    apartmentFormController.addStoryNumber(),
                              ),
                              // TODO: Fix the input number by keyboard.
                              Text('${apartmentFormController.storyNumber}'),
                              CountIconButton.minus(
                                onPressed: () =>
                                    apartmentFormController.removeStoryNumber(),
                              ),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffCACACF),
                              ),
                              const Text('تعداد واحدها:'),
                              CountIconButton.add(
                                onPressed: () =>
                                    apartmentFormController.addUnitNumber(),
                              ),
                              Text('${apartmentFormController.unitNumber}'),
                              CountIconButton.minus(
                                onPressed: () =>
                                    apartmentFormController.removeUnitNumber(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller:
                            apartmentFormController.addressTextController,
                        hintText: 'آدرس',
                        validator: (value) =>
                            Validators.textInputValidator(value),
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
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            Validators.amountInputValidator(value),
                        onSaved: (newValue) => apartmentFormController
                            .chargeAmountOnSaved(newValue),
                      ),
                      CustomTextField(
                        controller:
                            apartmentFormController.budgetTextController,
                        hintText: 'موجودی صندوق',
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            Validators.amountInputValidator(value),
                        // onChanged: (value) {
                        //   // TODO: FIX the issue
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
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 16),
                        child: SaveButton(
                          text: 'ثبت اطلاعات',
                          onPressed: () {
                            apartmentFormController.saveApartmentInfo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
