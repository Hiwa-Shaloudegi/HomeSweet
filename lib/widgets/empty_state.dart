import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/app_theme.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 1),
          SizedBox(
            height: 400,
            child: Center(
              child: Image.asset(
                'assets/images/empty.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              // SvgPicture.asset(
              //   'assets/images/empty.svg',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            message,
            style: AppTheme.textTheme().headlineLarge,
          ),
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
