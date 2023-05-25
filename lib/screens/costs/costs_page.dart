import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';

import '../../controllers/costs_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fab.dart';
import 'widgets/cost_bottomsheet.dart';
import 'widgets/cost_item.dart';

class CostsPage extends StatelessWidget {
  CostsPage({super.key});

  final costsController = Get.put(CostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Fab(
        onPressed: () {
          showCostFormBottomSheet(context).then(
            (value) => costsController.resetForm(),
          ); //! when the bottomShett closes
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // bottomNavigationBar: NavBar(),
      body: SafeArea(
        child: GetBuilder<CostsController>(
          builder: (costsController) {
            if (costsController.isLoading) {
              //TODO: create a beautiful loading widget
              return const Center(child: CircularProgressIndicator());
            } else {
              return costsController.allCosts.isEmpty
                  ? const EmptyState(message: 'هنوز هیچ هزینه ای ثبت نشده است.')
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
                          SizedBox(
                            height: Get.height * 0.79, //!
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: costsController.allCosts.length,
                              itemBuilder: (context, index) => CostItem(
                                cost: costsController.allCosts[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 24),
                            ),
                          ),
                        ],
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
