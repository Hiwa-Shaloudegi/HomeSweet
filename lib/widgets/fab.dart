import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  VoidCallback onPressed;
  Fab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: onPressed,
          elevation: 6,
          highlightElevation: 16,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
