import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';

import '../home_logic.dart';

class ListStockView extends StatelessWidget {
  const ListStockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(82, 60, 137, 0.05),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).code,
                    style: headline6,
                  ),
                ),
                Expanded(
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
          Obx(() {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    color: index % 2 == 1
                        ? const Color.fromRGBO(82, 60, 137, 0.05)
                        : AppColors.white,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          state.listStock[index].sym ?? "",
                          style: headline6!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: state.listStock[index].color),
                        )),
                        Expanded(
                            child: Text(
                          '${state.listStock[index].lastPrice}',
                          style: headline6.copyWith(
                              fontWeight: FontWeight.w700,
                              color: state.listStock[index].color),
                        )),

                        Expanded(
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
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                          '${state.listStock[index].lastVolume}',
                          style: headline6.copyWith(fontWeight: FontWeight.w700),
                        ),
                            )),
                      ],
                    ),
                  );
                },
                itemCount: state.listStock.length);
          }),
        ],
      ),
    );
  }
}
