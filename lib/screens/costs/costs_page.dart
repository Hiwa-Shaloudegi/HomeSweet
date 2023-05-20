import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';

import '../../controllers/costs_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fab.dart';
import 'widgets/cost_item.dart';
import 'widgets/create_cost_form.dart';

class CostsPage extends StatelessWidget {
  CostsPage({super.key});

  final costsController = Get.put(CostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Fab(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(25),
                  topStart: Radius.circular(25),
                ),
              ),
              builder: (context) => SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: CreateCostForm(costsController: costsController),
              ),
            ).then(
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
                return Center(child: CircularProgressIndicator());
              } else {
                return costsController.allCosts.isEmpty
                    ? const EmptyState(
                        message: 'هنوز هیچ هزینه ای ثبت نشده است.')
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
                            Container(
                              // color: Colors.amber,
                              height: Get.height * 0.79, //!
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: costsController.allCosts.length,
                                itemBuilder: (context, index) => CostItem(
                                  title: costsController.allCosts[index].title!,
                                  amount:
                                      costsController.allCosts[index].amount!,
                                  date: costsController.allCosts[index].date!,
                                  description: costsController
                                      .allCosts[index].description!,
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
        ));
  }
}
