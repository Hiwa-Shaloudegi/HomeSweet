import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweet_home/constants/colors.dart';
import 'package:sweet_home/controllers/staff_controller.dart';
import 'package:sweet_home/screens/auth/widgets/custom_text_field.dart';
import 'package:sweet_home/screens/staff/widgets/staff_bottomsheet.dart';
import 'package:sweet_home/screens/staff/widgets/staff_item.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fab.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final staffController = Get.put(StaffController());
  @override
  void initState() {
    staffController.getAllStaff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<StaffController>(builder: (staffController) {
      return GetBuilder<AuthController>(builder: (authController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: Visibility(
            visible: authController.loggedInUser != null
                ? authController.loggedInUser!.role == 'manager'
                : false,
            child: Fab(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) => Material(
                      color: Colors.transparent,
                      child: CupertinoAlertDialog(
                        title: Text(
                          'افزودن کارکنان',
                          style: textTheme.headlineLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'یک نقش را انتخاب کنید: ',
                                style: textTheme.titleLarge!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 105,
                              child: Row(
                                children: [
                                  Text(
                                    'مدیر',
                                    style: textTheme.titleLarge!
                                        .copyWith(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  Radio(
                                      value: 1,
                                      groupValue:
                                          staffController.radioGroupValue,
                                      onChanged: (value) {
                                        staffController.radioOnChanged(value);
                                        setState(() {});
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 105,
                              child: Row(
                                children: [
                                  Text(
                                    'لابی من',
                                    style: textTheme.titleLarge!
                                        .copyWith(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  Radio(
                                      value: 2,
                                      groupValue:
                                          staffController.radioGroupValue,
                                      onChanged: (value) {
                                        staffController.radioOnChanged(value);
                                        setState(() {});
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text(
                              'بستن',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              Future.delayed(
                                  const Duration(milliseconds: 100)); //!
                              showStaffFormBottomSheet(context).then(
                                (value) => staffController.resetForm(),
                              );
                            },
                            child: const Text(
                              'ادامه',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: authController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: GetBuilder<StaffController>(
                    builder: (staffController) {
                      if (staffController.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return staffController.allStaff.isEmpty
                            ? const EmptyState(
                                message: 'هنوز هیچ اطلاعاتی ثبت نشده است.')
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 24, bottom: 24),
                                      //TODO: search functionality
                                      child: CustomTextField.search(
                                        controller: null,
                                        validator: null,
                                        onSaved: null,
                                      ),
                                    ),
                                    Visibility(
                                      visible: false,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 24),
                                        child: Text(
                                          'اطلاعات کارکنان',
                                          style: textTheme.titleLarge,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount:
                                            staffController.allStaff.length,
                                        itemBuilder: (context, index) {
                                          return StaffItem(
                                              staff: staffController
                                                  .allStaff[index]);
                                        },
                                        separatorBuilder: (context, index) =>
                                            index == 0
                                                ? const Divider(
                                                    color:
                                                        AppColors.primaryColor,
                                                    thickness: 2,
                                                    height: 32,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  )
                                                : const SizedBox(height: 24),
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
      });
    });
  }
}
