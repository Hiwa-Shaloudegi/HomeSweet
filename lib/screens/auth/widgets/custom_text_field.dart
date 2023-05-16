import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final double padding;
  final Widget suffixIcon;
  final bool obscureText;
  // final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    // this.maxLength = 20,
    this.padding = 10,
    this.suffixIcon = const SizedBox.shrink(),
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
  });

  const CustomTextField.password({
    super.key,
    required this.controller,
    required this.validator,
    required this.onSaved,
    this.hintText = 'رمز عبور',
    // this.maxLength = 6,
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.visibility_off),
    this.obscureText = true,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.onChanged,
  });

  const CustomTextField.repeatPassword({
    super.key,
    required this.controller,
    required this.validator,
    required this.onSaved,
    this.hintText = 'تکرار رمز عبور',
    // this.maxLength = 6,
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.visibility_off),
    this.obscureText = true,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.onChanged,
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
            inputFormatters: keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\b'))]
                : inputFormatters,
            obscureText: obscureText,
            // maxLength: maxLength,
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 13,
              ),
              suffixIcon: suffixIcon,
              hintText: hintText,
              // counterText: '',
            ),
            validator: validator,
            onSaved: onSaved,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
