import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../controllers/costs_controller.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_bottomsheet_header.dart';
import '../../apartment/widgets/counter_icon_button.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../auth/widgets/save_button.dart';

class CreateCostForm extends StatelessWidget {
  const CreateCostForm({
    super.key,
    required this.costsController,
  });

  final CostsController costsController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: costsController.formKey,
      child: GetBuilder<CostsController>(builder: (_) {
        return Padding(
          //? solving textField issue when keyboard shows up.
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              FormBottomSheetHeader(title: 'ثبت هزینه'),
              Container(height: 8),
              CustomTextField(
                controller: costsController.titleTextController,
                hintText: 'عنوان هزینه',
                validator: (value) => Validators.textInputValidator(value),
                onSaved: (newValue) => costsController.titleOnSaved(newValue),
              ),
              CustomTextField(
                controller: costsController.descriptionTextController,
                hintText: 'توضیحات',
                validator: (value) =>
                    Validators.descriptionInputValidator(value),
                onSaved: (newValue) =>
                    costsController.descriptionOnSaved(newValue),
                maxLines: 2,
              ),
              CustomTextField.datePicker(
                controller: costsController.dateTextController,
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
                  costsController.dateTextController.text = label;
                },
                hintText: 'تاریخ',
                validator: (value) => Validators.dateInputValidator(value),
                onSaved: (newValue) => costsController.dateOnSaved(newValue),
                suffixIcon: const Icon(Icons.calendar_month_rounded),
              ),
              CustomTextField(
                controller: costsController.amountTextController,
                hintText: 'مقدار هزینه',
                validator: (value) => Validators.amountInputValidator(value),
                onSaved: (newValue) => costsController.amountOnSaved(newValue),
              ),
              Container(height: 16),
              Row(
                children: [
                  const Text('هزینه بین چند واحد تقسیم شود؟'),
                  const SizedBox(width: 16),
                  CountIconButton.add(
                    onPressed: () => costsController.addnumberOfUnits(),
                  ),
                  const SizedBox(width: 8),
                  Text('${costsController.numberOfUnits}'),
                  const SizedBox(width: 8),
                  CountIconButton.minus(
                    onPressed: () => costsController.removenumberOfUnits(),
                  ),
                ],
              ),
              Container(height: 32),
              SaveButton(
                text: 'ثبت اطلاعات',
                onPressed: () {
                  costsController.createCost();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
