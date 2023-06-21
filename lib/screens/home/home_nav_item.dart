import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/management_item.dart';

class HomeNavItem extends StatelessWidget {
  const HomeNavItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * 0.05),
          Container(
            height: Get.height * 0.75,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 180,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return ManagementItem(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
