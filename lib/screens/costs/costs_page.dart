import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';
import 'package:home_sweet/themes/app_theme.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../../controllers/costs_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fab.dart';
import 'widgets/cost_item.dart';

class CostsPage extends StatelessWidget {
  CostsPage({super.key});

  final costsController = Get.put(CostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Fab(onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: SafeArea(
          child: GetBuilder<CostsController>(
            builder: (costsController) {
              return costsController.costs.isEmpty
                  ? const EmptyState(message: 'هنوز هیچ هزینه ای ثبت نشده است')
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 24, bottom: 24),
                            child: CustomTextField.search(
                              controller: null,
                              validator: null,
                              onSaved: null,
                            ),
                          ),
                          CostItem(
                              title: 'نظافت ساختمان', items: costItems), //TODO:
                        ],
                      ),
                    );
            },
          ),
        ));
  }
}
