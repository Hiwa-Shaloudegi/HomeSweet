import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/charge_controller.dart';

class ChargeDropdownButtonField extends StatelessWidget {
  ChargeDropdownButtonField({
    super.key,
  });

  final chargeController = Get.put(ChargeController());

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      itemHeight: 48,
      borderRadius: BorderRadius.circular(24),
      iconEnabledColor: AppColors.primaryColor,
      iconSize: 28,
      value: chargeController.titleDropDownFieldValue, //?? 'شارژ ماهیانه',
      items: const [
        DropdownMenuItem(
          value: 'شارژ ماهیانه',
          child: Text('شارژ ماهیانه'),
        ),
        DropdownMenuItem(
          value: 'قبض آب',
          child: Text('قبض آب'),
        ),
        DropdownMenuItem(
          value: 'قبض برق',
          child: Text('قبض برق'),
        ),
        DropdownMenuItem(
          value: 'قبض گاز',
          child: Text('قبض گاز'),
        ),
      ],
      onSaved: (newValue) => chargeController.titleDropDownOnSaved(newValue),
      onChanged: (newValue) =>
          chargeController.titleDropDownFieldOnChanged(newValue),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
