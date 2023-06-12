import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/auth_controller.dart';

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
        // style: ButtonStyle(
        //     backgroundColor: MaterialStatePropertyAll(Colors.amber)),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
