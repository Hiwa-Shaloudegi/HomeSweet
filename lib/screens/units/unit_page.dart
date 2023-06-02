import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/widgets/empty_state.dart';

import '../../controllers/unit_controller.dart';
import '../../widgets/fab.dart';
import '../auth/widgets/custom_text_field.dart';
import 'widgets/unit_bottomsheet.dart';
import 'widgets/unit_form.dart';
import 'widgets/unit_item.dart';

class UnitPage extends StatelessWidget {
  UnitPage({super.key});

  final unitFormController = Get.put(UnitFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Fab(
        onPressed: () {
          sbowUnitFormBottomSheet(context).then(
            (value) => unitFormController.resetForm(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GetBuilder<UnitFormController>(
        builder: (unitFormController) {
          if (unitFormController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return unitFormController.allUnits.isEmpty
                ? const EmptyState(message: 'هنوز هیچ واحدی ثبت نشده است.')
                : _unitList(unitFormController);
          }
        },
      ),
    );
  }

  Widget _unitList(UnitFormController unitFormController) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 0),
            //TODO: search functionality
            child: CustomTextField.search(
              controller: null,
              validator: null,
              onSaved: null,
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: unitFormController.allUnits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 32),
              itemBuilder: (_, index) {
                var unit = unitFormController.allUnits[index];
                var owner = unit.owner;
                var tenant = unit.tenant;

                return UnitItem(unit: unit, tenant: tenant, owner: owner);
              },
            ),
          ),
        ],
      ),
    );
  }
}
