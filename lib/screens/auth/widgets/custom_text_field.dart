import 'package:flutter/material.dart';
import 'package:home_sweet/my_custom_icon_icons.dart';
import 'package:home_sweet/utils/validators.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double padding;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  // final String? validator;
  // final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    // required this.validator,
    this.padding = 10,
    this.suffixIcon = const SizedBox.shrink(),
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  const CustomTextField.password({
    super.key,
    // required this.validator,
    this.hintText = 'رمز عبور',
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.remove_red_eye_outlined),
    this.obscureText = true,
    this.keyboardType = TextInputType.number,
  });

  const CustomTextField.repeatPassword({
    super.key,
    // required this.validator,
    this.hintText = 'تکرار رمز عبور',
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.remove_red_eye_outlined),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
              suffixIcon: suffixIcon,
              hintText: hintText,
            ),
            onSaved: (newValue) {},
            validator: (value) => Validators.usernameValidator(value),
          ),
        ],
      ),
    );
  }
}
