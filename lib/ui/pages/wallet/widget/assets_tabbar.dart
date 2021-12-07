import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_dimens.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/response/account_status.dart';
import 'package:vf_app/utils/money_utils.dart';

class AssetsTabBar extends StatefulWidget {
  final AccountAssets assets;

  const AssetsTabBar({Key? key, required this.assets}) : super(key: key);

  @override
  State<AssetsTabBar> createState() => _AssetsTabBarState();
}

class _AssetsTabBarState extends State<AssetsTabBar>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginNormal),
      children: [
        rowData(S.of(context).total_assets,
            '${MoneyFormat.formatMoneyRound(widget.assets.assets ?? "")}đ'),
        const SizedBox(height: 20),
        rowData(S.of(context).cash_balance,
            '${MoneyFormat.formatMoneyRound(widget.assets.cashBalance ?? "")}đ'),
        const SizedBox(height: 20),
        rowData(S.of(context).collaborative_assets,
            '${MoneyFormat.formatMoneyRound(widget.assets.avaiColla ?? "")}đ'),
        const SizedBox(height: 20),
        rowData(S.of(context).collaborative_assets_total,
            '${MoneyFormat.formatMoneyRound(widget.assets.avaiColla ?? "")}đ'),
        const SizedBox(height: 20),
        rowData(S.of(context).deposit_fee,
            '${MoneyFormat.formatMoneyRound(widget.assets.depositFee ?? "")}đ'),
      ],
    );
  }

  Widget rowData(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: AppColors.gray88)),
        Text(right,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
