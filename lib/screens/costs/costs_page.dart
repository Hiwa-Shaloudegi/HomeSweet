import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';
import 'package:home_sweet/themes/app_theme.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:home_sweet/utils/validators.dart';
import 'package:home_sweet/widgets/navbar.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../controllers/costs_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fab.dart';
import '../apartment/widgets/counter_icon_button.dart';
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
                child: Form(
                  key: costsController.formKey,
                  child: GetBuilder<CostsController>(builder: (_) {
                    return Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ثبت هزینه',
                              style: AppTheme.textTheme().headlineLarge,
                            ),
                            IconButton(
                              onPressed: () {
                                costsController.resetForm();
                                Get.back();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        Container(height: 8),
                        CustomTextField(
                          controller: costsController.titleTextController,
                          hintText: 'عنوان هزینه',
                          validator: null,
                          onSaved: (newValue) =>
                              costsController.titleOnSaved(newValue),
                        ),
                        CustomTextField(
                          controller: costsController.descriptionTextController,
                          hintText: 'توضیحات',
                          validator: null,
                          onSaved: (newValue) =>
                              costsController.descriptionOnSaved(newValue),
                          maxLines: 2,
                        ),
                        CustomTextField(
                          // TODO: onTap --> open datePicker
                          controller: costsController.dateTextController,
                          hintText: 'تاریخ',
                          validator: null,
                          onSaved: (newValue) =>
                              costsController.dateOnSaved(newValue),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              Jalali? pickedDate = await showPersianDatePicker(
                                context: context,
                                initialDate: Jalali.now(),
                                firstDate: Jalali(1381, 5),
                                lastDate: Jalali(1450, 12),
                                helpText: 'انتخاب تاریخ 📆',
                                fieldHintText: 'مثال  1381/5/10'.toFarsiNumber,
                                errorFormatText:
                                    'تاریخ به صورت درستی وارد نشده است',
                                errorInvalidText:
                                    'تاریخ خارج از محدوده مجاز است',
                              );
                              var label = pickedDate!.formatFullDate();
                            },
                            child: const Icon(Icons.calendar_month_rounded),
                          ),
                        ),
                        CustomTextField(
                          controller: costsController.amountTextController,
                          hintText: 'مقدار هزینه',
                          validator: (value) =>
                              Validators.amountInputValidator(value),
                          onSaved: (newValue) =>
                              costsController.amountOnSaved(newValue),
                        ),
                        Container(height: 16),
                        Row(
                          children: [
                            const Text('هزینه بین چند واحد تقسیم شود؟'),
                            const SizedBox(width: 16),
                            CountIconButton.add(
                              onPressed: () =>
                                  costsController.addnumberOfUnits(),
                            ),
                            const SizedBox(width: 8),
                            Text('${costsController.numberOfUnits}'),
                            const SizedBox(width: 8),
                            CountIconButton.minus(
                              onPressed: () =>
                                  costsController.removenumberOfUnits(),
                            ),
                          ],
                        ),
                        Container(height: 32),
                        SaveButton(
                            text: 'ثبت اطلاعات',
                            onPressed: () {
                              // costsController.createCost();
                            })
                      ],
                    );
                  }),
                ),
              ),
            ).then((value) =>
                costsController.resetForm()); //! when the bottomShett closes
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // bottomNavigationBar: NavBar(),
        body: SafeArea(
          child: GetBuilder<CostsController>(
            builder: (costsController) {
              return costsController.allCosts.isEmpty
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
                          Container(
                            // color: Colors.amber,
                            height: Get.height * 0.79, //!
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 8,
                              itemBuilder: (context, index) => CostItem(
                                title: 'نظافت ساختمان',
                                items: costsController.costItems,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 24),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ));
  }
}
