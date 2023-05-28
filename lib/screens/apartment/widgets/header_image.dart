import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height / 2.5,
      decoration: const BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/apartment.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
