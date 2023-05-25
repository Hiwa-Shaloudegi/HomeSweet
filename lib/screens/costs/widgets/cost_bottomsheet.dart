import 'package:flutter/material.dart';

import 'cost_form.dart';

Future<dynamic> showCostFormBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(25),
        topStart: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: CostForm(),
      );
    },
  );
}
