import 'package:flutter/material.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:home_sweet/widgets/empty_state.dart';
import 'package:home_sweet/widgets/form_bottomsheet_header.dart';

import '../../themes/app_theme.dart';
import '../../utils/validators.dart';
import '../../widgets/fab.dart';
import '../auth/widgets/custom_text_field.dart';
import '../costs/widgets/cost_bottomsheet.dart';

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
            isDismissible: false, //! Do this for cost bottomSheet
            isScrollControlled: true,

            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(25),
                topStart: Radius.circular(25),
              ),
            ),
            builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 32.0, //! not responsible.
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                    ),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormBottomSheetHeader(title: 'افزودن واحد'),
                          Container(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text('طبقه'),
                                    const SizedBox(width: 16),
                                    DropdownButton(
                                      value: 1,
                                      borderRadius: BorderRadius.circular(16),
                                      items: [
                                        DropdownMenuItem<int>(
                                          value: 1,
                                          child: Text('1'.toFarsiNumber),
                                        ),
                                        DropdownMenuItem<int>(
                                          value: 2,
                                          child: Text('2'.toFarsiNumber),
                                        ),
                                        DropdownMenuItem<int>(
                                          value: 3,
                                          child: Text('3'.toFarsiNumber),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 32,
                                  width: 2,
                                  color: AppColors.dividerColor,
                                ),
                                Row(
                                  children: [
                                    const Text('واحد'),
                                    const SizedBox(width: 16),
                                    DropdownButton(
                                      value: 2,
                                      borderRadius: BorderRadius.circular(16),
                                      items: [
                                        DropdownMenuItem<int>(
                                          value: 1,
                                          child: Text('1'.toFarsiNumber),
                                        ),
                                        DropdownMenuItem<int>(
                                          value: 2,
                                          child: Text('2'.toFarsiNumber),
                                        ),
                                        DropdownMenuItem<int>(
                                          value: 3,
                                          child: Text('3'.toFarsiNumber),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: null,
                            hintText: 'شماره ثابت',
                            keyboardType: TextInputType.phone,
                            validator: null,
                            onSaved: (newValue) {},
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('وضعیت سکونت: '),
                              Radio(
                                value: 1,
                                groupValue: 1,
                                onChanged: (value) {},
                                visualDensity: VisualDensity.compact,
                                fillColor: const MaterialStatePropertyAll(
                                  AppColors.primaryColor,
                                ),
                              ),
                              const Text('مالک'),
                              const SizedBox(width: 8),
                              Radio(
                                value: 2,
                                groupValue: 1,
                                onChanged: (value) {},
                                visualDensity: VisualDensity.compact,
                                fillColor: const MaterialStatePropertyAll(
                                  AppColors.primaryColor,
                                ),
                              ),
                              const Text('خالی'),
                              const SizedBox(width: 8),
                              Radio(
                                value: 3,
                                groupValue: 1,
                                onChanged: (value) {},
                                visualDensity: VisualDensity.compact,
                                fillColor: const MaterialStatePropertyAll(
                                  AppColors.primaryColor,
                                ),
                              ),
                              const Text('اجاره'),
                            ],
                          ),
                          const Divider(
                            color: AppColors.dividerColor,
                            height: 50,
                            thickness: 2,
                            indent: 36,
                            endIndent: 36,
                          ),
                          Text(
                            'اطلاعات مالک :',
                            style: AppTheme.textTheme().headlineLarge,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: null,
                            hintText: 'نام',
                            validator: (value) =>
                                Validators.textInputValidator(value),
                            onSaved: null,
                          ),
                          CustomTextField(
                            controller: null,
                            hintText: 'نام خانوادگی',
                            validator: (value) =>
                                Validators.textInputValidator(value),
                            onSaved: null,
                          ),
                          const CustomTextField(
                            controller: null,
                            hintText: 'شماره تلفن',
                            keyboardType: TextInputType.phone,
                            validator: null,
                            onSaved: null,
                          ),
                          Visibility(
                            visible: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(
                                  color: AppColors.dividerColor,
                                  height: 50,
                                  thickness: 2,
                                  indent: 36,
                                  endIndent: 36,
                                ),
                                Text(
                                  'اطلاعات مستاجر :',
                                  style: AppTheme.textTheme().headlineLarge,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: null,
                                  hintText: 'نام',
                                  validator: (value) =>
                                      Validators.textInputValidator(value),
                                  onSaved: null,
                                ),
                                CustomTextField(
                                  controller: null,
                                  hintText: 'نام خانوادگی',
                                  validator: (value) =>
                                      Validators.textInputValidator(value),
                                  onSaved: null,
                                ),
                                const CustomTextField(
                                  controller: null,
                                  hintText: 'شماره تلفن',
                                  keyboardType: TextInputType.phone,
                                  validator: null,
                                  onSaved: null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 64),
                          SaveButton(
                            text: 'ثبت اطلاعات',
                            bottomMargin: 0,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
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
