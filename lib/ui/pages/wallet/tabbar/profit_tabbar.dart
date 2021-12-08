import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_dimens.dart';
import 'package:vf_app/configs/app_configs.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/response/list_account_response.dart';
import 'package:vf_app/ui/pages/user/user_logic.dart';
import 'package:vf_app/ui/widgets/dropdown/app_drop_down.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';
import 'package:vf_app/utils/money_utils.dart';

import '../wallet_logic.dart';

class ProfitTabBar extends StatefulWidget {
  const ProfitTabBar({Key? key}) : super(key: key);

  @override
  _ProfitTabBarState createState() => _ProfitTabBarState();
}

class _ProfitTabBarState extends State<ProfitTabBar>
    with AutomaticKeepAliveClientMixin {
  final walletState = Get.find<WalletLogic>().state;

  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline8 =
        Theme.of(context).textTheme.headline6!.copyWith(fontSize: 10);
    final headline7 = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 12, fontWeight: FontWeight.w700);
    super.build(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginNormal),
      children: [
        Row(
          children: [
            Expanded(
                child: AppTextFieldWidget(
              label: S.of(context).start_day,
              hintText: AppConfigs.dateAPIFormat,
            )),
            const SizedBox(width: 15),
            Expanded(
                child: AppTextFieldWidget(
              label: S.of(context).end_day,
              hintText: AppConfigs.dateAPIFormat,
            )),
          ],
        ),
        const SizedBox(height: 20),
        Obx(() {
          return AppDropDownWidget<Account>(
              label: S.of(context).account,
              value: userState.account.value,
              onChanged: (value) {
                userLogic.changeAccount(value!);
              },
              items: userState.listAccount
                  .map((e) => DropdownMenuItem<Account>(
                        value: e,
                        onTap: () {},
                        child: Text(e.accCode ?? ""),
                      ))
                  .toList());
        }),
        const SizedBox(height: 20),
        AppTextFieldWidget(
          label: S.of(context).profit_total,
          inputController: walletState.profitController,
        ),
        const SizedBox(height: 29),
        Obx(() {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          S.of(context).stock_code,
                          style: headline8,
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            S.of(context).volume_short,
                            style: headline8,
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            S.of(context).gain_loss_percent,
                            style: headline8,
                          ),
                        )),
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                S.of(context).gain_loss_value,
                                style: headline8,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          walletState.portfolioList[index].symbol ?? "",
                          style: headline7,
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            walletState.portfolioList[index].avaiableVol ?? "",
                            style: headline7,
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            walletState.portfolioList[index].gainLossPer ?? "",
                            style: headline7.copyWith(
                                color:
                                    walletState.portfolioList[index].glColor),
                          ),
                        )),
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${MoneyFormat.formatMoneyRound(walletState
                                    .portfolioList[index].gainLossValue ??
                                    "")} đ',
                                style: headline7.copyWith(
                                    color: walletState
                                        .portfolioList[index].glColor),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemCount: walletState.portfolioList.length,
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
