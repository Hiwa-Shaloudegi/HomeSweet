import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_sweet/controllers/auth_controller.dart';
import 'package:home_sweet/controllers/staff_controller.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../constants/colors.dart';
import '../../../constants/storage_keys.dart';
import '../../../models/staff.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_bottomsheet_header.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../auth/widgets/save_button.dart';

class StaffForm extends StatelessWidget {
  StaffForm({super.key});

  final staffController = Get.put(StaffController());
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Staff loggedInUser = Get.find<AuthController>().loggedInUser!;
    log(loggedInUser.username!); //!

    bool isStaffToupdate = staffController.staffToUpdate == null ? false : true;
    bool isUserItem = false;

    if (isStaffToupdate) {
      if (loggedInUser.username == staffController.staffToUpdate!.username &&
          loggedInUser.password == staffController.staffToUpdate!.password) {
        isUserItem = true;
      } else {
        isUserItem = false;
      }
    }
    log(staffController.role);

    return GetBuilder<StaffController>(
      builder: (staffController) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: Get.height * 0.25,
                      color: const Color(0xffABC8FF),
                      margin: const EdgeInsets.only(bottom: 60),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        staffController.staffToUpdate != null
                            ? Text(
                                staffController.staffToUpdate!.role == 'manager'
                                    ? 'ثبت اطلاعات مدیر'
                                    : 'ثبت اطلاعات لابی من',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            : Text(
                                staffController.role == 'manager'
                                    ? 'ثبت اطلاعات مدیر'
                                    : 'ثبت اطلاعات لابی من',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                        right: 20,
                        left: 20,
                      ),
                      child: Form(
                        key: staffController.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const FormBottomSheetHeader(title: 'افزودن کارکنان'),

                            CustomTextField(
                              controller:
                                  staffController.firstNameTextController,
                              hintText: 'نام',
                              keyboardType: TextInputType.text,
                              validator: Validators.textInputValidator,
                              onSaved: (newValue) =>
                                  staffController.firstNameOnSaved(newValue),
                            ),
                            CustomTextField(
                              controller:
                                  staffController.lastNameTextController,
                              hintText: 'نام خانوادگی',
                              keyboardType: TextInputType.text,
                              validator: Validators.textInputValidator,
                              onSaved: (newValue) =>
                                  staffController.lastNameOnSaved(newValue),
                            ),
                            CustomTextField(
                              controller:
                                  staffController.phoneNumberTextController,
                              hintText: 'شماره تلفن',
                              keyboardType: TextInputType.number,
                              validator: Validators.phoneNumberInputValidator,
                              onSaved: (newValue) =>
                                  staffController.phoneNumberOnSaved(newValue),
                            ),

                            CustomTextField.datePicker(
                              controller: staffController.dateTextController,
                              enabled: loggedInUser.role == 'manager',
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                Jalali? pickedDate =
                                    await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1381, 5),
                                  lastDate: Jalali(1450, 12),
                                  helpText: 'انتخاب تاریخ 📆',
                                  fieldHintText:
                                      'مثال  1381/5/10'.toFarsiNumber,
                                  errorFormatText:
                                      'تاریخ به صورت درستی وارد نشده است.',
                                  errorInvalidText:
                                      'تاریخ خارج از محدوده مجاز است.',
                                );
                                String label = pickedDate!.formatFullDate();
                                staffController.dateTextController.text = label;
                              },
                              hintText: 'تاریخ شروع کار',
                              validator: (value) =>
                                  Validators.dateInputValidator(value),
                              onSaved: (newValue) =>
                                  staffController.dateOnSaved(newValue),
                              suffixIcon:
                                  const Icon(Icons.calendar_month_rounded),
                            ),
                            CustomTextField(
                              controller: staffController.salaryTextController,
                              hintText: 'حقوق ماهیانه',
                              enabled: loggedInUser.role == 'manager',
                              keyboardType: TextInputType.number,
                              validator: Validators.amountInputValidator,
                              onSaved: (newValue) =>
                                  staffController.salaryOnSaved(newValue),
                            ),
                            Visibility(
                              visible: (isStaffToupdate && isUserItem) ||
                                  !isStaffToupdate,
                              child: CustomTextField(
                                controller:
                                    staffController.usernameTextController,
                                hintText: 'نام کاربری',
                                validator: (value) =>
                                    Validators.usernameValidator(value),
                                onSaved: (newValue) =>
                                    staffController.usernameOnSaved(newValue),
                              ),
                            ),
                            Visibility(
                              visible: (isStaffToupdate && isUserItem) ||
                                  !isStaffToupdate,
                              child: CustomTextField.password(
                                hintText: staffController.staffToUpdate != null
                                    ? 'رمز عبور جدید'
                                    : 'رمز عبور',
                                controller:
                                    staffController.passwordTextController,
                                obscureText: !staffController.isPasswordVisible,
                                suffixIcon: GestureDetector(
                                  onTap: () => staffController
                                      .togglePasswordVisibility(),
                                  child: staffController.isPasswordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                validator: (value) =>
                                    Validators.passwordValidator(value),
                                onSaved: (newValue) =>
                                    staffController.passwordOnSaved(newValue),
                              ),
                            ),
                            const SizedBox(height: 32),
                            SaveButton(
                              text: 'ثبت اطلاعات',
                              bottomMargin: 0,
                              onPressed: () {
                                staffController.saveData();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //! should have close icon?
                // Positioned(
                //   left: 12,
                //   top: 36,
                //   child: IconButton(
                //     onPressed: () {
                //       Get.back();
                //     },
                //     icon: const Icon(Icons.close),
                //   ),
                // ),
                Positioned(
                  top: Get.height * 0.25 - 70,
                  right: (Get.width - Get.width * 0.26) / 2,
                  child: SizedBox(
                    width: Get.width * 0.26,
                    height: Get.width * 0.26,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/manager.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.25 + 2,
                  right: ((Get.width - Get.width * 0.26) / 2) - 6,
                  child: const Icon(
                    Icons.camera_enhance,
                    color: AppColors.primaryColor,
                    size: 27,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
