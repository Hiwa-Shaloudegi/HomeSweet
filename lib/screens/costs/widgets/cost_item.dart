import 'package:flutter/material.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../../../constants/colors.dart';
import '../../../themes/app_theme.dart';

var costItems = [
  Row(
    children: [
      Icon(
        Icons.attach_money_rounded,
        color: AppColors.primaryColor,
      ),
      SizedBox(width: 12),
      Text('هزینه کل :  '),
      Text('800000'.toTooman()),
      Text('  تومان'),
    ],
  ),
  Row(
    children: [
      Icon(
        Icons.calendar_month_rounded,
        color: AppColors.primaryColor,
      ),
      SizedBox(width: 12),
      Text('تاریخ :'),
      Text(' 12 اریبهشت 1402'.toFarsiNumber),
    ],
  ),
  Row(
    children: [
      Icon(
        Icons.edit_document,
        color: AppColors.primaryColor,
      ),
      SizedBox(width: 12),
      Text('توضیحات :'),
      Text('بابت نظافت کامل، راه پله ها و ... '),
    ],
  ),
];

class CostItem extends StatelessWidget {
  final String title;
  final double totalHeight;
  final double bodyHeight;
  final List<Widget> items;

  const CostItem({
    super.key,
    required this.title,
    required this.items,
    this.totalHeight = 200,
    this.bodyHeight = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: totalHeight, //200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF6F7F9),
            offset: Offset(0, -1),
          ),
          BoxShadow(
            color: Color(0xffF6F7F9),
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: Color(0xffF6F7F9),
            offset: Offset(3, 0),
          ),
          BoxShadow(
            color: Color(0xffF6F7F9),
            offset: Offset(-3, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: bodyHeight, //60,  //! totalHeight * 0.3
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title, //'نظافت ساختمان',
                  style: AppTheme.textTheme().labelLarge,
                ),
                Spacer(),
                Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 14),
                Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0,
            ),
            child: Container(
              // color: Colors.amber,
              height: totalHeight - bodyHeight, //firstContainer - second
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
