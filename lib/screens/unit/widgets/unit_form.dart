import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../../../constants/colors.dart';
import '../../../controllers/apartment_form_controller.dart';
import '../../../controllers/unit_controller.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_bottomsheet_header.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../auth/widgets/save_button.dart';
import 'owner_form.dart';
import 'tenant_form.dart';

class UnitForm extends StatelessWidget {
  UnitForm({super.key});

  final unitFormController = Get.put(UnitFormController());
  final apartmentFormController = Get.put(ApartmentFormController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitFormController>(builder: (_) {
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
                              value:
                                  unitFormController.floorDropdownButtonValue,
                              borderRadius: BorderRadius.circular(16),
                              items: List.generate(
                                apartmentFormController
                                    .apartment!.storyNumber!, // !
                                (index) => DropdownMenuItem<int>(
                                  value: index + 1,
                                  child: Text('${index + 1}'.toFarsiNumber),
                                ),
                              ),
                              onChanged: (newValue) => unitFormController
                                  .floorDropdownButtonOnChanged(newValue),
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
                              value: unitFormController
                                  .unitNumberDropdownButtonValue,
                              borderRadius: BorderRadius.circular(16),
                              items: List.generate(
                                apartmentFormController
                                    .apartment!.unitNumber!, //!
                                (index) => DropdownMenuItem<int>(
                                  value: index + 1,
                                  child: Text('${index + 1}'.toFarsiNumber),
                                ),
                              ),
                              onChanged: (newValue) => unitFormController
                                  .unitDropdownButtonOnChanged(newValue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller:
                        unitFormController.unitPhoneNumberTextController,
                    hintText: 'شماره ثابت',
                    keyboardType: TextInputType.number,
                    validator: Validators.phoneNumberInputValidator,
                    onSaved: (newValue) {},
                    // onChanged: (String? p0) {
                    //   if (p0 != null) {
                    //     print(p0.toFarsiNumber);
                    //   }
                    // },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('وضعیت سکونت: '),
                      Radio(
                        value: 1,
                        groupValue: unitFormController.radioGroupValue,
                        onChanged: (value) =>
                            unitFormController.radioOnChanged(value),
                        visualDensity: VisualDensity.compact,
                        fillColor: const MaterialStatePropertyAll(
                          AppColors.primaryColor,
                        ),
                      ),
                      const Text('مالک'),
                      const SizedBox(width: 8),
                      Radio(
                        value: 2,
                        groupValue: unitFormController.radioGroupValue,
                        onChanged: (value) =>
                            unitFormController.radioOnChanged(value),
                        visualDensity: VisualDensity.compact,
                        fillColor: const MaterialStatePropertyAll(
                          AppColors.primaryColor,
                        ),
                      ),
                      const Text('خالی'),
                      const SizedBox(width: 8),
                      Radio(
                        value: 3,
                        groupValue: unitFormController.radioGroupValue,
                        onChanged: (value) =>
                            unitFormController.radioOnChanged(value),
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
                  OwnerForm(),
                  Visibility(
                    visible: unitFormController.isTenantFormVisible,
                    child: TenantForm(),
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
    });
  }
}
