import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/unit_controller.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/validators.dart';
import '../../auth/widgets/custom_text_field.dart';

class OwnerForm extends StatelessWidget {
  OwnerForm({super.key});

  final unitFormController = Get.find<UnitFormController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اطلاعات مالک :',
          style: AppTheme.textTheme().headlineLarge,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: unitFormController.ownerNameTextController,
          hintText: 'نام',
          validator: (value) => Validators.textInputValidator(value),
          onSaved: (newValue) => unitFormController.ownerNameOnSaved(newValue),
        ),
        CustomTextField(
          controller: unitFormController.ownerLastNameTextController,
          hintText: 'نام خانوادگی',
          validator: (value) => Validators.textInputValidator(value),
          onSaved: (newValue) =>
              unitFormController.ownerLastNameOnSaved(newValue),
        ),
        CustomTextField(
          controller: unitFormController.ownerPhoneNumberTextController,
          hintText: 'شماره تلفن',
          keyboardType: TextInputType.number,
          validator: Validators.phoneNumberInputValidator,
          onSaved: (newValue) =>
              unitFormController.ownerPhoneNumberOnSaved(newValue),
        ),
      ],
    );
  }
}
