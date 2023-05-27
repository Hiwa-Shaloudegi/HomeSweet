import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/unit_controller.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/validators.dart';
import '../../auth/widgets/custom_text_field.dart';

class TenantForm extends StatelessWidget {
  TenantForm({super.key});

  final unitFormController = Get.find<UnitFormController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: AppColors.dividerColor,
          height: 50,
          thickness: 2,
          indent: 36,
          endIndent: 36,
        ),
        Text(
          'اطلاعات مستاجر :',
          style: AppTheme.textTheme().headlineLarge,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: unitFormController.tenantNameTextController,
          hintText: 'نام',
          validator: (value) => Validators.textInputValidator(value),
          onSaved: null,
        ),
        CustomTextField(
          controller: unitFormController.tenantLastNameTextController,
          hintText: 'نام خانوادگی',
          validator: (value) => Validators.textInputValidator(value),
          onSaved: null,
        ),
        CustomTextField(
          controller: unitFormController.tenantPhoneNumberTextController,
          hintText: 'شماره تلفن',
          keyboardType: TextInputType.number,
          validator: Validators.phoneNumberInputValidator,
          onSaved: null,
        ),
      ],
    );
  }
}
