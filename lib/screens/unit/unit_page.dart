import 'package:flutter/material.dart';
import 'package:home_sweet/widgets/empty_state.dart';

import '../../widgets/fab.dart';
import 'widgets/unit_form.dart';

class UnitPage extends StatelessWidget {
  const UnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Fab(
        onPressed: () {
          showModalBottomSheet(
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
              return UnitForm();
            },
          ).then(
            (value) {},
          ); //! .then() --> when the bottomShett closes
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Builder(
        builder: (context) {
          if (true) {
            return const EmptyState(message: 'هنوز هیچ واحدی ثبت نشده است.');
          } else {
            return const Text('data');
          }
        },
      ),
    );
  }
}
