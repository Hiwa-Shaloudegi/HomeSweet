import 'package:flutter/material.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../constants/colors.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
  });

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
        ), //border raiuds of dropdown button
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          menuMaxHeight: 300,
          underline: const SizedBox.shrink(),
          value: 1,
          iconEnabledColor: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
          items: List.generate(
            20,
            (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text('${index + 1}'.toFarsiNumber),
            ),
          ),
          onChanged: (newValue) {
            // unitFormController
            //     .unitDropdownButtonOnChanged(newValue);
          },
        ),
      ),
    );
  }
}
