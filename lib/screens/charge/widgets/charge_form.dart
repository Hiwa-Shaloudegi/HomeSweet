import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/charge_controller.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../constants/colors.dart';
import '../../../controllers/apartment_form_controller.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/form_bottomsheet_header.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../auth/widgets/save_button.dart';
import 'charge_dropdown_button_field.dart';

class ChargeForm extends StatelessWidget {
  ChargeForm({super.key});

  final apartmentFormController = Get.put(ApartmentFormController());
  final chargeController = Get.put(ChargeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChargeController>(builder: (chargeController) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: 12, //! not responsible.
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            ),
            child: Form(
              key: chargeController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormBottomSheetHeader(title: 'ثبت شارژ و قبض'),
                  Container(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('طبقه'),
                            const SizedBox(width: 16),
                            CustomDropdown(
                              value: chargeController.floorDropdownButtonValue,
                              itemsValue: apartmentFormController.storyNumber,
                              onChanged: (newValue) => chargeController
                                  .floorDropdownButtonOnChanged(newValue),
                            ),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 2,
                          color: AppColors.dividerColor,
                        ),
                        Row(
                          children: [
                            const Text('واحد'),
                            const SizedBox(width: 16),
                            CustomDropdown(
                              value: chargeController
                                  .unitNumberDropdownButtonValue,
                              itemsValue: apartmentFormController.unitNumber,
                              onChanged: (newValue) => chargeController
                                  .unitDropdownButtonOnChanged(newValue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'عنوان هزینه',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          // height:
                          //     70, // set the height of the Container to your desired value
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          //   border: Border.all(
                          //     color: Theme.of(context).dividerColor,
                          //     width: 1,
                          //   ),
                          // ),
                          //TODO: increase the height.
                          child: ChargeDropdownButtonField(),
                        ),
                      ],
                    ),
                  ),
                  // CustomTextField(
                  //   controller: chargeController.titleTextController,
                  //   hintText: 'عنوان هزینه',
                  //   keyboardType: TextInputType.text,
                  //   validator: Validators.textInputValidator,
                  //   onSaved: (newValue) =>
                  //       chargeController.titleOnSaved(newValue),
                  // ),
                  CustomTextField.datePicker(
                    controller: chargeController.dateTextController,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      Jalali? pickedDate = await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1381, 5),
                        lastDate: Jalali(1450, 12),
                        helpText: 'انتخاب تاریخ 📆',
                        fieldHintText: 'مثال  1381/5/10'.toFarsiNumber,
                        errorFormatText: 'تاریخ به صورت درستی وارد نشده است.',
                        errorInvalidText: 'تاریخ خارج از محدوده مجاز است.',
                      );
                      String label = pickedDate!.formatFullDate();
                      chargeController.dateTextController.text = label;
                    },
                    hintText: 'تاریخ تراکنش',
                    validator: (value) => Validators.dateInputValidator(value),
                    onSaved: (newValue) =>
                        chargeController.dateOnSaved(newValue),
                    suffixIcon: const Icon(Icons.calendar_month_rounded),
                  ),
                  CustomTextField(
                    controller: chargeController.amountTextController,
                    hintText: 'مقدار هزینه',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.amountInputValidator(value),
                    onSaved: (newValue) =>
                        chargeController.amountOnSaved(newValue),
                  ),
                  const SizedBox(height: 24),
                  SaveButton(
                    text: 'ثبت اطلاعات',
                    bottomMargin: 0,
                    onPressed: () {
                      chargeController.saveData();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
