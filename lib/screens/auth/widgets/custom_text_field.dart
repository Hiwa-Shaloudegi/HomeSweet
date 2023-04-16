import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/password_controller.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final double padding;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    this.padding = 10,
    this.suffixIcon = const SizedBox.shrink(),
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  CustomTextField.password({
    super.key,
    required this.controller,
    required this.validator,
    required this.onSaved,
    this.hintText = 'رمز عبور',
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.visibility_off),
    this.obscureText = true,
    this.keyboardType = TextInputType.number,
  });

  CustomTextField.repeatPassword({
    super.key,
    required this.controller,
    required this.validator,
    required this.onSaved,
    this.hintText = 'تکرار رمز عبور',
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.visibility_off),
    this.obscureText = true,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 13,
              ),
              suffixIcon: suffixIcon,
              hintText: hintText,
            ),
            validator: validator,
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
