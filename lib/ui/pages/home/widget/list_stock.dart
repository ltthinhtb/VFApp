import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';
import 'package:vf_app/utils/money_utils.dart';

import '../home_logic.dart';

class ListStockView extends StatelessWidget {
  const ListStockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final headline6 = Theme.of(context).textTheme.headline6;
    int flex = 4;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(82, 60, 137, 0.05),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: flex + 1,
                    child: Text(
                      S.of(context).code,
                      style: headline6,
                    ),
                  ),
                  Expanded(
                    flex: flex,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).price,
                            style: headline6,
                          ),
                          const SizedBox(height: 3),
                          SvgPicture.asset(AppImages.down_arrow)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: flex,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppImages.left_button),
                          const SizedBox(width: 5),
                          Text(
                            '<%>',
                            style: headline6,
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(AppImages.right_button),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: flex + 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.of(context).volumn,
                        style: headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (state.listStock.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 17),
                          color: index % 2 == 1
                              ? const Color.fromRGBO(82, 60, 137, 0.05)
                              : AppColors.white,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: flex + 1,
                                  child: Text(
                                    state.listStock[index].sym ?? "",
                                    style: headline6!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: state.listStock[index].color),
                                  )),
                              Expanded(
                                  flex: flex,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: state.listStock[index]
                                                        .mapColorChange[
                                                    'lastPrice'] ==
                                                true
                                            ? state.listStock[index].color!.withOpacity(0.4)
                                            : null),
                                    child: Text(
                                      '${state.listStock[index].lastPrice?.toStringAsFixed(2)}',
                                      style: headline6.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: state.listStock[index].color!
                                              .withOpacity(1)),
                                    ),
                                  )),
                              Expanded(
                                  flex: flex,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${state.listStock[index].ot}',
                                      style: headline6.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: state.listStock[index].color),
                                    ),
                                  )),
                              Expanded(
                                  flex: flex + 1,
                                  child: Container(
                                    // decoration: BoxDecoration(
                                    //     color: state.listStock[index]
                                    //         .mapColorChange[
                                    //     'lastVolume'] ==
                                    //         true
                                    //         ? state.listStock[index].color!.withOpacity(0.4)
                                    //         : null),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${MoneyFormat.formatVol10('${state.listStock[index].lastVolume?.toInt() ?? "0"}')}',
                                        style: headline6.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        );
                      },
                      itemCount: state.listStock.length);
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SvgPicture.asset(AppImages.search_big_size),
                        const SizedBox(height: 15),
                        Text(
                          S.of(context).no_stock_hint_text,
                          textAlign: TextAlign.center,
                          style: headline6!
                              .copyWith(color: AppColors.gray88, height: 1.2),
                        ),
                        const SizedBox(height: 10),
                        ButtonFill(
                          voidCallback: () {},
                          title: S.of(context).add_stock,
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25)),
                        )
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
