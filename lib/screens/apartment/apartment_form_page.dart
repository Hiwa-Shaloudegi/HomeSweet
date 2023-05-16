import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/screens/auth/widgets/custom_text_field.dart';
import 'package:home_sweet/screens/auth/widgets/save_button.dart';
import 'package:home_sweet/utils/validators.dart';

import 'widgets/counter_icon_button.dart';

class ApartmentFormPage extends StatelessWidget {
  const ApartmentFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Get.height / 2.5,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/apartment.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ثبت اطلاعات آپارتمان',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 18),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: TextEditingController(), //!
                    hintText: 'نام آپارتمان',
                    validator: (value) =>
                        Validators.usernameValidator(value), //!
                    onSaved: (p0) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      children: [
                        const Text('تعداد طبقات:'),
                        const CounteIconButton.add(),
                        const Text('0'),
                        const CounteIconButton.minus(),
                        Container(
                          width: 1,
                          height: 24,
                          margin: const EdgeInsets.only(left: 6.7),
                          color: const Color(0xffCACACF),
                        ),
                        const Text('تعداد واحدها:'),
                        const CounteIconButton.add(),
                        const Text('0'),
                        const CounteIconButton.minus(),
                      ],
                    ),
                  ),
                  CustomTextField(
                    controller: TextEditingController(), //!
                    hintText: 'آدرس',
                    validator: (value) =>
                        Validators.usernameValidator(value), //!
                    onSaved: (p0) {},
                    suffixIcon: const Icon(
                      Icons.location_on_rounded,
                      size: 24,
                      color: AppColors.unselectedItemColor,
                    ),
                  ),
                  CustomTextField(
                    controller: TextEditingController(), //!
                    hintText: 'شارژ ماهیانه هر واحد',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.usernameValidator(value), //!
                    onSaved: (p0) {},
                  ),
                  CustomTextField(
                    controller: TextEditingController(), //!
                    hintText: 'موجودی صندوق',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.usernameValidator(value), //!
                    onSaved: (p0) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: SaveButton(
                      text: 'ثبت اطلاعات',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
