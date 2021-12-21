import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/pages/menu/page/setting.dart';
import 'package:vf_app/ui/pages/order_list/order_list_logic.dart';
import 'package:vf_app/utils/error_message.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final logic = Get.put(OrderListLogic());
  final state = Get.find<OrderListLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          child: Text(
            "Sổ lệnh",
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView(
            children: [buildHeader(), buildListOrder()],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
        color: AppColors.primary2,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).code}/${S.of(context).account_short}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).orderType}/${S.of(context).status_short}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).match}/${S.of(context).total}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).match_price}/${S.of(context).price}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).order_number_short}",
              textAlign: TextAlign.right,
              style: AppTextStyle.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOrder() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        primary: false,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: state.listOrder.length,
        itemBuilder: (context, idx) => buildItem(state.listOrder[idx]),
      ),
    );
  }

  Widget buildItem(IndayOrder data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: AppColors.primary2,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.symbol ?? "null",
                  style: AppTextStyle.bodyText1,
                ),
                Text(
                  data.accountCode ?? "null",
                  style: AppTextStyle.bodyText1,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.side == "B" ? S.of(context).buy : S.of(context).sell,
                  style: AppTextStyle.caption2.copyWith(
                      color:
                          data.side == "B" ? AppColors.green : AppColors.red),
                ),
                Text(
                  MessageOrder.getStatusOrder(data),
                  style: AppTextStyle.bodyText2,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.matchVolume.toString(),
                  style: AppTextStyle.caption2,
                ),
                Text(
                  data.volume.toString(),
                  style: AppTextStyle.bodyText2,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.matchValue.toString(),
                  style: AppTextStyle.caption2,
                ),
                Text(
                  data.showPrice.toString(),
                  style: AppTextStyle.bodyText2,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.orderNo!,
                  style: AppTextStyle.caption2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
