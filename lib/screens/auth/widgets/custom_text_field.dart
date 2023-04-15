import 'package:flutter/material.dart';
import 'package:home_sweet/my_custom_icon_icons.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double padding;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.padding = 10,
    this.suffixIcon = const SizedBox.shrink(),
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  const CustomTextField.password({
    super.key,
    this.hintText = 'رمز عبور',
    this.padding = 10,
    // TODO: Icon for eye in passeord field
    this.suffixIcon =
        const Icon(MyCustomIcon.eyeOff), //const Icon(MyCustomIcon.),
    this.obscureText = true,
    this.keyboardType = TextInputType.number,
  });

  const CustomTextField.repeatPassword({
    super.key,
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
            textInputAction: TextInputAction.next,
            keyboardType: keyboardType,
            obscureText: obscureText,
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
