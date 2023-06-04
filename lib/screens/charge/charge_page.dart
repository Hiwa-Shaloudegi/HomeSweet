import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/charge_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fab.dart';
import '../auth/widgets/custom_text_field.dart';
import 'widgets/charge_bottomsheet.dart';
import 'widgets/charge_item.dart';

class ChargePage extends StatelessWidget {
  ChargePage({super.key});

  final chargeController = Get.put(ChargeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Fab(
        onPressed: () {
          sbowChargeFormBottomSheet(context).then(
            (value) => chargeController.resetForm(),
          );
        },
      ),
      body: GetBuilder<ChargeController>(builder: (chargeController) {
        if (chargeController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return chargeController.allCharges.isEmpty
              ? const EmptyState(message: 'هیچ رسید شارژی ثبت نشده است.')
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 60),
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
                          itemCount: chargeController.allCharges.length,
                          itemBuilder: (context, index) => ChargeItem(
                            charge: chargeController.allCharges[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 24),
                        ),
                      ),
                    ],
                  ),
                );
        }
      }),
    );
  }
}
