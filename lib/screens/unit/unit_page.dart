import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/unit_repository.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:home_sweet/widgets/empty_state.dart';

import '../../constants/colors.dart';
import '../../controllers/unit_controller.dart';
import '../../themes/app_theme.dart';
import '../../widgets/fab.dart';
import '../auth/widgets/custom_text_field.dart';
import 'widgets/unit_form.dart';

class UnitPage extends StatelessWidget {
  UnitPage({super.key});

  final unitFormController = Get.put(UnitFormController());

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
                : Padding(
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
                        SizedBox(
                          height: Get.height * 0.8,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: unitFormController.allUnits.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 32),
                            itemBuilder: (_, index) {
                              var unit = unitFormController.allUnits[index];
                              var owner = unit.owner;
                              var tenant = unit.tenant;

                              return Container(
                                width: double.infinity,
                                height: 210, //! 200,
                                // margin: EdgeInsets.symmetric(vertical: 24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffF6F7F9),
                                      offset: Offset(0, -1),
                                      blurRadius: 3,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      offset: Offset(0, 5),
                                      blurRadius: 3,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      offset: Offset(3, 0),
                                      blurRadius: 3,
                                    ),
                                    BoxShadow(
                                      color: Color(0xffF6F7F9),
                                      offset: Offset(-3, 0),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 60, //60,  //! totalHeight * 0.3
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          topLeft: Radius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'واحد ${unit.number}'
                                                            .toFarsiNumber,
                                                        style:
                                                            AppTheme.textTheme()
                                                                .labelLarge,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        unit.unitStatus?.split(
                                                                    '.')[1] ==
                                                                'tenant'
                                                            ? '(مستاجر)'
                                                            : '(مالک)',
                                                        style:
                                                            AppTheme.textTheme()
                                                                .labelLarge!
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    'طبقه ${unit.floor}'
                                                        .toFarsiNumber,
                                                    style: AppTheme.textTheme()
                                                        .labelLarge!
                                                        .copyWith(
                                                          fontSize: 16,
                                                          color: Colors.white70,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            child: IconButton(
                                              onPressed: () {},
                                              // onPressed: () {
                                              //   //! selected Cost model.
                                              //   costsController.costToUpdate = cost;
                                              //   costsController.loadSelectedCostData();
                                              //   //!

                                              //   showCostFormBottomSheet(context).then(
                                              //     (value) => costsController.resetForm(),
                                              //   ); //! when the bottomShett closes
                                              // },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 22,
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: () async {
                                              int? id =
                                                  await UnitRepository.getId(
                                                      unit);
                                              if (id != null) {
                                                unitFormController
                                                    .deleteUnit(id);
                                              }
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: const Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 0,
                                      ),
                                      child: SizedBox(
                                        height: 140, //firstContainer - second
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  color: AppColors.primaryColor,
                                                ),
                                                const SizedBox(width: 12),
                                                const Text('ساکن :  '),
                                                unit.tenantId != null
                                                    ? Text(
                                                        '${tenant!.firstName} ${tenant.lastName}')
                                                    : Text(
                                                        '${owner?.firstName} ${owner?.lastName}',
                                                      ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.phone_enabled_rounded,
                                                  color: AppColors.primaryColor,
                                                ),
                                                const SizedBox(width: 12),
                                                const Text('شماره تماس : '),
                                                // unit.unitStatus !=
                                                //         UnitStatus.tenant
                                                //             .toString()
                                                unit.tenantId != null
                                                    ? Text(
                                                        '${tenant!.tenantPhoneNumber}'
                                                            .toFarsiNumber,
                                                        style: const TextStyle(
                                                          letterSpacing: 1,
                                                        ),
                                                      )
                                                    : Text(
                                                        '${owner!.ownerPhoneNumber}'
                                                            .toFarsiNumber,
                                                        style: const TextStyle(
                                                          letterSpacing: 1,
                                                        ),
                                                      )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.telegram,
                                                  color: AppColors.primaryColor,
                                                ),
                                                const SizedBox(width: 12),
                                                const Text('شماره منزل : '),
                                                Expanded(
                                                  child: Text(
                                                    '${unit.phoneNumber}'
                                                        .toFarsiNumber,
                                                    style: const TextStyle(
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
