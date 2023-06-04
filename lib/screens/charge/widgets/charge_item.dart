import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_sweet/database/charge_repository.dart';
import 'package:home_sweet/utils/extensions.dart';

import '../../../constants/colors.dart';
import '../../../controllers/charge_controller.dart';
import '../../../models/charge.dart';
import '../../../themes/app_theme.dart';

class ChargeItem extends StatelessWidget {
  final Charge charge;

  final double totalHeight;
  final double bodyHeight;

  ChargeItem({
    super.key,
    required this.charge,
    this.totalHeight = 210,
    this.bodyHeight = 60,
  });

  final chargeController = Get.find<ChargeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: totalHeight,
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
            height: bodyHeight,
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
                    charge.title!,
                    style: AppTheme.textTheme().labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: IconButton(
                    onPressed: () {},
                    // onPressed: () {
                    //   //! selected Cost model.
                    //   costsController.costToUpdate = cost;
                    //   costsController
                    //       .loadSelectedCostData();
                    //   //!

                    //   showCostFormBottomSheet(context)
                    //       .then(
                    //     (value) =>
                    //         costsController.resetForm(),
                    //   ); //! when the bottomShett closes
                    // },
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
                    int? id = await ChargeRepository.getId(charge);
                    if (id != null) {
                      chargeController.deleteCharge(id);
                    }
                  },
                  // onPressed: () {},
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
            child: SizedBox(
              height: totalHeight - bodyHeight, //firstContainer - second
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 12),
                      Text(' طبقه: ${charge.unitId} '), //TODO:get from unit
                      const SizedBox(width: 8),
                      Text(' واحد: ${charge.unitId} '), //TODO:get from unit
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money_rounded,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 12),
                      const Text('هزینه کل :  '),
                      Text(charge.amount.toString().toFarsiNumber),
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
                      Text(charge.date.toString().toFarsiNumber),
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
