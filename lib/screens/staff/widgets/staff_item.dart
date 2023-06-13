import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/auth_controller.dart';
import 'package:home_sweet/controllers/staff_controller.dart';
import 'package:home_sweet/database/staff_repository.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../../../constants/colors.dart';
import '../../../models/staff.dart';
import '../../../themes/app_theme.dart';
import 'staff_bottomsheet.dart';
// import 'cost_bottomsheet.dart';

class StaffItem extends StatelessWidget {
  final Staff staff;

  final double totalHeight;
  final double bodyHeight;

  StaffItem({
    super.key,
    required this.staff,
    this.totalHeight = 250,
    this.bodyHeight = 60,
  });

  final staffController = Get.find<StaffController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffController>(builder: (staffController) {
      return Get.find<AuthController>().loggedInUser == null
          ? Center()
          : Container(
              width: double.infinity,
              height: totalHeight,
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
                    height: bodyHeight, //60,  //! totalHeight * 0.3
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            staff.firstName != null
                                ? '${staff.firstName} ${staff.lastName}'
                                : 'تکمیل پروفایل', //!!!
                            style: AppTheme.textTheme().labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Visibility(
                            visible:
                                Get.find<AuthController>().loggedInUser!.role ==
                                        'manager'
                                    ? true
                                    : Get.find<AuthController>()
                                            .loggedInUser!
                                            .username ==
                                        staff.username,
                            child: IconButton(
                              onPressed: () {
                                //! selected Staff model.
                                staffController.staffToUpdate = staff;
                                staffController.loadSelectedStaffData();

                                showStaffFormBottomSheet(context).then(
                                  (value) => staffController.resetForm(),
                                );
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              Get.find<AuthController>().loggedInUser!.role ==
                                      'manager'
                                  ? true
                                  : false,
                          child: IconButton(
                            onPressed: () async {
                              int? id = await StaffRepository.getId(staff);
                              if (id != null) {
                                staffController.deleteStaff(id);
                              }
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.red,
                            ),
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
                      height:
                          totalHeight - bodyHeight, //firstContainer - second
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              const Text('نقش:  '),
                              Text(
                                staff.role.toString() == 'manager'
                                    ? 'مدیر'
                                    : 'لابی من',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money_rounded,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              const Text('حقوق:  '),
                              Text(
                                staff.salary != null
                                    ? staff.salary.toString().toTooman()
                                    : 'نامشخص',
                              ),
                              Text(staff.salary != null ? '  تومان' : ''),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              const Text('شماره تماس:  '),
                              Text(
                                staff.staffPhoneNumber != null
                                    ? staff.staffPhoneNumber
                                        .toString()
                                        .toFarsiNumber
                                    : 'نامشخص',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              const Text('تاریخ شروع کار: '),
                              Text(
                                staff.startingDate != null
                                    ? staff.startingDate
                                        .toString()
                                        .toFarsiNumber
                                    : 'نامشخص',
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
    });
  }
}
