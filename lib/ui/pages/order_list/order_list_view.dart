import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/ui/pages/main/main_view.dart';
import 'package:vf_app/ui/pages/order_list/order_list_logic.dart';
import 'package:vf_app/ui/pages/order_list/page/order_detail.dart';
import 'package:vf_app/ui/widgets/animation_widget/expanded_widget.dart';
import 'package:vf_app/ui/widgets/button/material_button.dart';
import 'package:vf_app/ui/widgets/dialog/custom_dialog.dart';
import 'package:vf_app/ui/widgets/dropdown/dropdown_widget.dart';
import 'package:vf_app/utils/error_message.dart';
import 'package:vf_app/utils/extension.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   orderStatus = [
    //     S.of(context).all,
    //     S.of(context).wating_match,
    //     S.of(context).partial_matched,
    //     S.of(context).matched,
    //     S.of(context).cancelled,
    //     S.of(context).rejected,
    //     S.of(context).wating_match
    //   ];
    // });
    // if (state.orderStatus.value.isEmpty) {
    //   state.orderStatus.value = orderStatus[0];
    // }
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Container(
            child: Text(
              S.of(context).order_note,
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
                child: Text(state.selectedMode.value
                    ? S.of(context).cancel_short
                    : S.of(context).select),
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
            child: Column(
              children: [
                buildFilter(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [buildHeader(), buildListOrder()],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AnimatedScale(
          scale: state.selectedMode.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CustomMaterialButton(
                      onPressed: () async {
                        bool? _r = await CustomDialog.showConfirmDialog(
                          mainKey,
                          S.of(context).confirm_cancel_order,
                          [
                            S.of(context).are_you_sure_cancel_all_order,
                          ],
                          buttonColors: [AppColors.primary2, AppColors.primary],
                          textButtonColors: [
                            AppColors.primary,
                            AppColors.white
                          ],
                        );
                        if (_r ?? false) {
                          state.selectedMode.value = false;
                          try {
                            await logic.selectAll();
                            await logic.cancelOrder();
                          } catch (e) {
                            AppSnackBar.showError(message: e.toString());
                          }
                        }
                      },
                      color: AppColors.primary2,
                      child: Text(
                        S.of(context).cancel_all_orders,
                        style: AppTextStyle.H5Bold.copyWith(
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CustomMaterialButton(
                      onPressed: () async {
                        bool? _r = await CustomDialog.showConfirmDialog(
                          mainKey,
                          S.of(context).confirm_cancel_order,
                          [
                            S.of(context).are_you_sure_cancel_this_order,
                          ],
                          buttonColors: [AppColors.primary2, AppColors.primary],
                          textButtonColors: [
                            AppColors.primary,
                            AppColors.white
                          ],
                        );
                        if (_r ?? false) {
                          state.selectedMode.value = false;
                          try {
                            await logic.cancelOrder();
                          } catch (e) {
                            AppSnackBar.showError(message: e.toString());
                          }
                        }
                      },
                      color: AppColors.primary,
                      child: Text(
                        S.of(context).cancel_chose_orders,
                        style:
                            AppTextStyle.H5Bold.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget buildFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Obx(
          () => Row(
            children: [
              Expanded(
                flex: 10,
                child: DropdownWidget<String>(
                  isExpanded: true,
                  label: S.of(context).status,
                  value: state.orderStatus.value.isNotIn(orderStatus)
                      ? orderStatus[0]
                      : state.orderStatus.value,
                  onChanged: (_value) {
                    state.orderStatus.value = _value ?? orderStatus[0];
                  },
                  items: orderStatus
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Container(
                            child: Text(
                              e,
                              style: AppTextStyle.H7Regular,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // selectedItemBuilder: (context) => orderStatus
                  //     .map(
                  //       (e) => Container(
                  //         child: Text(
                  //           e,
                  //           style:
                  //               AppTextStyle.H7Regular.copyWith(color: Colors.black),
                  //         ),
                  //       ),
                  //     )
                  //     .toList(),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 10,
                child: DropdownWidget<String>(
                  isExpanded: true,
                  label: S.of(context).orderType,
                  value: state.orderType.value.isNotIn(orderType)
                      ? orderType[0]
                      : state.orderType.value,
                  onChanged: (_value) {
                    state.orderType.value = _value ?? orderType[0];
                  },
                  items: orderType
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Container(
                            child: Text(
                              e,
                              style: AppTextStyle.H7Regular,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // selectedItemBuilder: (context) => orderStatus
                  //     .map(
                  //       (e) => Container(
                  //         child: Text(
                  //           e,
                  //           style:
                  //               AppTextStyle.H7Regular.copyWith(color: Colors.black),
                  //         ),
                  //       ),
                  //     )
                  //     .toList(),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 10,
                child: DropdownWidget<String>(
                  isExpanded: true,
                  label: S.of(context).account,
                  value: state.account.value.isEmpty
                      ? state.listAccount[0]
                      : state.account.value,
                  onChanged: (_value) {
                    state.account.value = _value ?? state.listAccount[0];
                  },
                  items: state.listAccount
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Container(
                            child: Text(
                              e,
                              style: AppTextStyle.H7Regular,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // selectedItemBuilder: (context) => orderStatus
                  //     .map(
                  //       (e) => Container(
                  //         child: Text(
                  //           e,
                  //           style:
                  //               AppTextStyle.H7Regular.copyWith(color: Colors.black),
                  //         ),
                  //       ),
                  //     )
                  //     .toList(),
                ),
              ),
            ],
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
        // reverse: true,
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
        onPressed: () {
          // Get.to(OrderDetail(data: data));
          Navigator.push(
            context,
            GetPageRoute(
              page: () => OrderDetail(data: data),
            ),
          );
        },
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
              Obx(
                () => ExpandedSection(
                  expand: state.selectedMode.value,
                  axis: Axis.horizontal,
                  child: Transform.scale(
                    scale: 1.2,
                    child: showCheckBox(_status)
                        ? Checkbox(
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
                          )
                        : Container(
                            width: 18,
                            height: 18,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                  ),
                ),
              ),
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

List<String> orderStatus = [
  "Tất cả",
  "Chờ khớp",
  "Khớp 1 phần",
  "Đã khớp",
  "Đã huỷ",
  "Từ chối",
  "Chờ huỷ"
];

List<String> orderType = ["Tất cả", "Mua", "Bán"];
