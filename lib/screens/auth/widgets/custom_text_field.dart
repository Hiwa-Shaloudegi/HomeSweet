import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double padding;
  final Widget suffixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.padding = 10,
    this.suffixIcon = const SizedBox.shrink(),
  });

  const CustomTextField.password({
    super.key,
    this.hintText = 'رمز عبور',
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.remove_red_eye_outlined),
  });

  const CustomTextField.repeatPassword({
    super.key,
    this.hintText = 'تکرار رمز عبور',
    this.padding = 10,
    this.suffixIcon = const Icon(Icons.remove_red_eye_outlined),
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
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
