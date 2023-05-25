import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final double bottomMargin;
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bottomMargin = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
