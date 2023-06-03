import 'package:flutter/material.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../constants/colors.dart';

class CustomDropdown extends StatelessWidget {
  final int? value;
  final List<DropdownMenuItem<int>>? items;
  final int? itemsValue;
  final void Function(int?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.itemsValue,
    this.items,
  }) : assert(
          items == null && itemsValue != null ||
              items != null && itemsValue == null,
          'Only one of items or itemsValue must be initialized.',
        );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[100],
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          menuMaxHeight: 300,
          underline: const SizedBox.shrink(),
          value: value,
          iconEnabledColor: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
          items: items ??
              List.generate(
                itemsValue!,
                (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1}'.toFarsiNumber),
                ),
              ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
