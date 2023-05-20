import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/controllers/costs_controller.dart';
import 'package:home_sweet/database/cost_repository.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../../../constants/colors.dart';
import '../../../models/cost.dart';
import '../../../themes/app_theme.dart';

class CostItem extends StatelessWidget {
  final Cost cost;

  final double totalHeight;
  final double bodyHeight;

  CostItem({
    super.key,
    required this.cost,
    this.totalHeight = 210,
    this.bodyHeight = 60,
  });

  final costsController = Get.find<CostsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: totalHeight, //200,
      // margin: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF6F7F9),
            offset: Offset(0, -1),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color.fromARGB(255, 230, 230, 230),
            offset: Offset(0, 5),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color.fromARGB(255, 230, 230, 230),
            offset: Offset(3, 0),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color(0xffF6F7F9),
            offset: Offset(-3, 0),
            blurRadius: 3,
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
                Expanded(
                  child: Text(
                    cost.title!,
                    style: AppTheme.textTheme().labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: IconButton(
                    onPressed: () {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    int? id = await CostRepository.getId(cost);
                    if (id != null) {
                      costsController.deleteCost(id);
                    } else {
                      print('---------------->  ID was null');
                    }
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
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
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money_rounded,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 12),
                      const Text('هزینه کل :  '),
                      Text(cost.amount.toString().toTooman()),
                      const Text('  تومان'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 12),
                      const Text('تاریخ : '),
                      Text(cost.date.toString().toFarsiNumber),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_document,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 12),
                      const Text('توضیحات : '),
                      Expanded(
                        child: Text(
                          cost.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
