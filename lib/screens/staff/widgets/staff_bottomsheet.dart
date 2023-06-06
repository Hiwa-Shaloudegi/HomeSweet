import 'package:flutter/material.dart';

import 'staff_form.dart';

Future<dynamic> showStaffFormBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(25),
        topStart: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return StaffForm();
    },
  );
}
