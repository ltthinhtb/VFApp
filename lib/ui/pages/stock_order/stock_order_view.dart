import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/services/setting_service.dart';
import 'package:vf_app/ui/commons/webview.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_logic.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_state.dart';
import 'package:vf_app/ui/pages/stock_order/widget/number_input.dart';
import 'package:vf_app/ui/pages/stock_order/widget/stock_order_appbar.dart';
import 'package:vf_app/ui/pages/stock_order/widget/stock_order_confirm.dart';
import 'package:vf_app/ui/widgets/animation_widget/price_row.dart';
import 'package:vf_app/ui/widgets/animation_widget/switch.dart';
import 'package:vf_app/ui/widgets/animation_widget/total_volumn_row.dart';
import 'package:vf_app/utils/stock_utils.dart';

class StockOrderPage extends StatefulWidget {
  StockOrderPage({Key? key, this.selectedStock, this.isBuy = true})
      : super(key: key);
  final bool isBuy;
  final StockCompanyData? selectedStock;

  @override
  _StockOrderPageState createState() => _StockOrderPageState();
}

class _StockOrderPageState extends State<StockOrderPage> {
  final logic = Get.put(StockOrderLogic());
  final state = Get.find<StockOrderLogic>().state;

  //Bỏ settingService đi
  final settingService = Get.find<SettingService>();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _volController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      state.isBuy.value = widget.isBuy;
      _priceController.text = state.price.toString();
      _volController.text = state.vol.toString();
    });
  }

  void changeStock(StockCompanyData? data) async {
    // print(data?.stockCode);
    if (data != null) {
      await logic.getStockInfo(data);
      _priceController.text = state.price.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StockOrderAppbar(
        onLeadingPress: () {},
        onSelectStockCode: (data) => changeStock(data),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView(
            // primary: false,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              buildTopItem(),
              buildHeader(),
              build3Gia(),
              buildVolPercent(),
              buildBSButton(),
              buildPriceTypes(),
              buildPriceInput(),
              buildInfoColumn(),
            ],
          ),
        ),
      ),
      floatingActionButton: MaterialButton(
        minWidth: width - 30,
        height: 50,
        color: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () {
          if (state.selectedStock.value.stockCode != null &&
              state.vol.value > 0) {
            Get.to(StockOrderConfirm());
          }
        },
        child: Text(
          "Đặt lệnh",
          style: AppTextStyle.H5Bold.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildTopItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: Obx(
          () => state.selectedStock.value.stockCode != null
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: state.selectedStock.value.stockCode! + "  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            TextSpan(
                              text: state.selectedStock.value.postTo!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ]),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Get.to(
                              WebViewPage(
                                  title: "Chart",
                                  url:
                                      "https://info.sbsi.vn/chart/?symbol=${state.selectedStock.value.stockCode}&language=vi&theme=light"),
                            );
                          },
                          shape: const CircleBorder(),
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primaryVariant,
                          child: SvgPicture.asset(AppImages.switch_diagram),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: settingService.currentLocate.value ==
                                        const Locale.fromSubtags(
                                            languageCode: 'vi')
                                    ? state.selectedStock.value.nameVn
                                    : state.selectedStock.value.nameEn ??
                                        state.selectedStock.value.nameVn,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Column(
                  children: [
                    const Text('Chưa có cổ phiếu nào được chọn'),
                    const Text('Vui lòng chọn cổ phiếu muốn đặt lệnh')
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: state.selectedStockInfo.value.lastPrice != null
              ? AppColors.primary2
              : AppColors.primaryOpacity,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Text(
                state.selectedStockInfo.value.lastPrice != null
                    ? state.selectedStockInfo.value.lastPrice.toString()
                    : "0.0",
                style: AppTextStyle.H1.copyWith(
                  color: state.selectedStockInfo.value.lastPrice != null
                      ? StockUtil.itemColorWithColor(
                          state.selectedStockInfo.value.cl!)
                      : null,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.selectedStockInfo.value.ot != null
                        ? state.selectedStockInfo.value.ot!
                        : "0.0",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: state.selectedStockInfo.value.ot != null
                          ? StockUtil.itemColorWithColor(
                              state.selectedStockInfo.value.cl!)
                          : null,
                    ),
                  ),
                  Text(
                    state.selectedStockInfo.value.ot != null
                        ? logic.getChangePc()
                        : "0.0%",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: state.selectedStockInfo.value.ot != null
                          ? StockUtil.itemColorWithColor(
                              state.selectedStockInfo.value.cl!)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).volumn,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockInfo.value.lot != null
                        ? StockUtil.formatVol10(
                            state.selectedStockInfo.value.lot!)
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).ceil,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockInfo.value.c != null
                        ? state.selectedStockInfo.value.c!.toString()
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).reference_short,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockInfo.value.r != null
                        ? state.selectedStockInfo.value.r!.toString()
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).floor,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockInfo.value.f != null
                        ? state.selectedStockInfo.value.f!.toString()
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build3Gia() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockInfo.value.g1?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g1?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockInfo.value.g2?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g2?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockInfo.value.g3?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g3?.volumn?.toDouble() ??
                            0,
                  )
                ],
              ),
            ),
            Container(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockInfo.value.g4?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g4?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockInfo.value.g5?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g5?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockInfo.value.g6?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g6?.volumn?.toDouble() ??
                            0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildVolPercent() {
    return Obx(
      () => Container(
        // margin: const EdgeInsets.only(bottom: 5),
        child: TotalVolumnPercentRow(
          sum: state.sumBSVol.value,
          buyValue: state.sumBuyVol.value,
          sellValue: state.sumSellVol.value,
        ),
      ),
    );
  }

  Widget buildBSButton() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedSwitch(
          trueLabel: S.of(context).buy,
          falseLabel: S.of(context).sell,
          value: state.isBuy.value,
          trueColor: AppColors.green,
          falseColor: AppColors.red,
          padding: 15,
          onChange: (val) {
            state.isBuy.value = val;
            logic.getCashBalance();
          },
        ),
      ),
    );
  }

  Widget buildPriceTypes() {
    return Obx(() {
      if (state.loading.value) {
        return Container(
          child: Row(
            children: nullString.asMap().entries.map<Widget>((entry) {
              int idx = entry.key;
              return buidButtonPrice(nullString, idx);
            }).toList(),
          ),
        );
      } else {
        switch (state.stockExchange.value) {
          case StockExchange.HSX:
            return Container(
              child: Row(
                children: pricesHSX.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  return buidButtonPrice(pricesHSX, idx);
                }).toList(),
              ),
            );
          case StockExchange.HNX:
            return Container(
              child: Row(
                children: pricesHNX.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  return buidButtonPrice(pricesHNX, idx);
                }).toList(),
              ),
            );
          default:
            return Container(
              child: Row(
                children: pricesUPCOM.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  return buidButtonPrice(pricesUPCOM, idx);
                }).toList(),
              ),
            );
        }
      }
    });
  }

  Widget buidButtonPrice(List<String> prices, int index) {
    return Obx(
      () => Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : 5,
            right: index == (prices.length - 1) ? 0 : 5,
          ),
          child: MaterialButton(
            onPressed: () {
              state.priceType.value = prices[index];
              if (state.selectedStock.value.stockCode != null &&
                  prices[index] == "MP") {
                state.price.value =
                    state.selectedStockInfo.value.lastPrice!.toDouble();
                _priceController.text = state.price.value.toString();
              }
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: state.priceType.value == prices[index]
                ? AppColors.primary
                : AppColors.primary2,
            splashColor: state.priceType.value == prices[index]
                ? AppColors.primary2.withOpacity(0.5)
                : AppColors.background.withOpacity(0.5),
            child: Text(
              prices[index],
              style: AppTextStyle.H5Bold.copyWith(
                color: state.priceType.value == prices[index]
                    ? Colors.white
                    : AppColors.background,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPriceInput() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: const Text("Giá :"),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: NumberInputField(
                      label: "Giá",
                      editingController: _priceController,
                      dist: 0.1,
                      enabled: state.selectedStock.value.stockCode != null
                          ? true
                          : false,
                      onChange: (value) {
                        state
                          ..price.value = value
                          ..priceType.value = "LO";
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: const Text("Khối lượng :"),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: NumberInputField(
                      label: "Khối lượng",
                      editingController: _volController,
                      dist: 10,
                      enabled: state.selectedStock.value.stockCode != null
                          ? true
                          : false,
                      onChange: (value) {
                        _volController.text = value.toStringAsFixed(0);
                        state.vol.value = value.round();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller, double dist,
      bool enabled) {
    return NumberInputField(
      label: label,
      editingController: controller,
      dist: dist,
      enabled: enabled,
    );
  }

  Widget buildInfoColumn() {
    return Obx(() {
      if (state.loading.value) {
        return Container();
      } else {
        if (state.isBuy.value) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: state.selectedStockInfo.value.lastPrice != null
                  ? AppColors.primary2
                  : AppColors.primaryOpacity,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).mr,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.accountStatus.value.mr != null
                            ? StockUtil.formatMoney(
                                double.parse(state.accountStatus.value.mr!))
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).ee,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.selectedCashBalance.value.ee != null
                            ? StockUtil.formatMoney(double.parse(
                                state.selectedCashBalance.value.ee ?? "0"))
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).pp,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.selectedCashBalance.value.pp != null
                            ? StockUtil.formatMoney(double.parse(
                                state.selectedCashBalance.value.pp ?? "0"))
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).maxVolumeBuyAvaiable,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.selectedCashBalance.value.volumeAvaiable != null
                            ? StockUtil.formatVol(
                                double.parse(state.selectedCashBalance.value
                                        .volumeAvaiable ??
                                    "0"),
                              )
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: state.selectedStockInfo.value.lastPrice != null
                  ? AppColors.primary2
                  : AppColors.primaryOpacity,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    S.of(context).maxVolumeSellAvaiable,
                    style: AppTextStyle.caption2,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    state.selectedCashBalance.value.volumeAvaiable != null
                        ? StockUtil.formatVol(
                            double.parse(state
                                    .selectedCashBalance.value.volumeAvaiable ??
                                "0"),
                          )
                        : "0",
                    style: AppTextStyle.bodyText2,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }
      }
    });
  }
}

List<String> pricesHSX = ["LO", "MP", "ATC", "ATO"];
List<String> pricesHNX = ["LO", "MTL", "MOK", "MAK", "PLO"];

List<String> pricesUPCOM = ["LO"];
List<String> nullString = [""];
