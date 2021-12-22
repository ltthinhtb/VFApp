import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/ui/pages/main/main_view.dart';
import 'package:vf_app/ui/pages/order_list/order_list_logic.dart';
import 'package:vf_app/ui/widgets/animation_widget/expanded_widget.dart';
import 'package:vf_app/ui/widgets/dialog/custom_dialog.dart';
import 'package:vf_app/utils/error_message.dart';
import 'package:vf_app/utils/stock_utils.dart';

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
    var width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Container(
            child: Text(
              "Sổ lệnh",
              style: AppTextStyle.H3,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                state.selectedMode.value = !state.selectedMode.value;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                child: Text(state.selectedMode.value ? "Huỷ" : "Chọn"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: RefreshIndicator(
            onRefresh: () async {
              logic.getOrderList();
            },
            child: ListView(
              children: [buildHeader(), buildListOrder()],
            ),
          ),
        ),
        floatingActionButton: AnimatedScale(
          scale: state.selectedMode.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: MaterialButton(
            minWidth: width - 30,
            height: 50,
            color: AppColors.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            onPressed: () async {
              bool? _r = await CustomDialog.showConfirmDialog(
                mainKey,
                "Xác nhận huỷ lệnh",
                ["Bạn có chắc chắn muốn hủy lệnh này?"],
                buttonColors: [AppColors.primary2, AppColors.primary],
                textButtonColors: [AppColors.primary, AppColors.white],
              );
              if (_r ?? false) {
                state.selectedMode.value = false;
                logic.cancelOrder();
              }
            },
            child: Text(
              "Huỷ lệnh đã chọn",
              style: AppTextStyle.H5Bold.copyWith(color: Colors.white),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    String _status = MessageOrder.getStatusOrder(data);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MaterialButton(
        onPressed: () {},
        onLongPress: () {
          if (!state.selectedMode.value) {
            state.selectedMode.value = true;
          }
        },
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        color: AppColors.primary2,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              showCheckBox(_status)
                  ? Obx(
                      () => ExpandedSection(
                        expand: state.selectedMode.value,
                        axis: Axis.horizontal,
                        child: Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            // hoverColor: AppColors.green,
                            fillColor: MaterialStateProperty.resolveWith(
                                (states) => getColor(states)),
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3)),
                              side: BorderSide(
                                color: logic.itemIsChecked(data.orderNo!)
                                    ? Colors.black
                                    : AppColors.green,
                              ),
                            ),
                            side: const BorderSide(),
                            value: logic.itemIsChecked(data.orderNo!),
                            onChanged: (value) {
                              if (value!) {
                                state.selectedListOrder.add(data);
                              } else {
                                state.selectedListOrder.removeWhere((element) =>
                                    element.orderNo == data.orderNo);
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.symbol ?? "null",
                      style: AppTextStyle.bodyText2,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.side == "B" ? S.of(context).buy : S.of(context).sell,
                      style: AppTextStyle.bodyText2.copyWith(
                        color:
                            data.side == "B" ? AppColors.green : AppColors.red,
                      ),
                    ),
                    Text(
                      _status,
                      style: AppTextStyle.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.matchVolume.toString(),
                      style: AppTextStyle.bodyText2,
                    ),
                    Text(
                      data.volume.toString(),
                      style: AppTextStyle.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StockUtil.formatPrice(data.matchPrice),
                      style: AppTextStyle.bodyText2,
                    ),
                    Text(
                      data.showPrice.toString(),
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
                      data.orderNo!,
                      style: AppTextStyle.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool showCheckBox(String status) {
    switch (status) {
      case "Khớp 1 phần":
        return true;
      case "Chờ khớp":
        return true;
      default:
        return false;
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.scrolledUnder,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.transparent;
    }
    return AppColors.green;
  }
}
