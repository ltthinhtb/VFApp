import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/commons/app_bottom_sheet.dart';

import '../home_logic.dart';

class MarketOption extends StatelessWidget {
  const MarketOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                AppBottomSheet.show(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).menu,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(
                        height: 26,
                      )
                    ],
                  ),
                );
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.grayF2,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Text(
                        state.market.value,
                        style: headline6!.copyWith(fontWeight: FontWeight.w700),
                      );
                    }),
                    SvgPicture.asset(AppImages.chevron_down)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 8.5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImages.add_square),
                const SizedBox(width: 5),
                Text(
                  S.of(context).code,
                  style: headline6!.copyWith(color: AppColors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
